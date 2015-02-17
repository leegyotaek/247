class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token, :age

  before_save :downcase_email
  before_create :create_activation_digest
  
  has_many :pictures, as: :imageable , dependent: :destroy
  accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes['name'].blank? } , :allow_destroy => true

  has_many :microposts , dependent: :destroy

  
  #matchings

  has_many :complet_relationships, ->{where status: "matched" } , class_name: "Relationship",
                         foreign_key: "matcher_id",
                         dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                         foreign_key: "matcher_id",
                         dependent: :destroy
  has_many :passive_relationships, -> { where status: "requested" } , class_name: "Relationship",
                         foreign_key: "matched_id",
                         dependent: :destroy
  
  has_many :matchers, through: :complet_relationships, source: :matched
  has_many :pending_matchers , through: :active_relationships, source: :matched
  has_many :req_matchers, through: :passive_relationships, source: :matcher


  #friends
  has_many :friendships,  dependent: :destroy 
  has_many :complet_friendships, -> { where status: "friends" } , class_name: "Friendship"
  has_many :friends , through: :complet_friendships
  has_many :passive_friendships ,  -> { where status: "pending" }, class_name: "Friendship",
              foreign_key: "friend_id", dependent: :destroy
  has_many :request_friends, through: :passive_friendships , source: :user


  has_many :languages ,-> { where sort: nil } , dependent: :destroy
  accepts_nested_attributes_for :languages, :reject_if => :all_blank , :allow_destroy => true

  has_many :wish_languages ,  -> { where sort: "wish" } , class_name: "Language"
  accepts_nested_attributes_for :wish_languages, :reject_if => :all_blank , :allow_destroy => true

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }
  has_secure_password

  validates :password, length: {minimum: 6}, allow_blank: true


  def language_name
    ::LanguageSelect::LANGUAGES[language]
  end



  def self.digest(string)
  	 cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  	
  end

  def self.new_token
    SecureRandom.urlsafe_base64 #return random string

  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
   BCrypt::Password.new(digest).is_password?(token)
    
  end

  def forget
    update_attribute(:remember_digest, nil)
    
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  #Sends activation email
  def send_activation_email
     UserMailer.account_activation(self).deliver_now
    
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
    
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
    
  end






  #   def feed
  #   following_ids = "SELECT followed_id FROM relationships
  #                    WHERE  follower_id = :user_id"
  #   Micropost.where("user_id IN (#{following_ids})
  #                    OR user_id = :user_id", user_id: id)
  #   end
  
  # def follow(other_user)
  #   active_relationships.create(followed_id: other_user.id)
  # end

  # def unfollow(other_user )
  #   active_relationships.find_by(followed_id: other_user.id).destroy
  # end


  # def following?(other_user)
  #   following.include?(other_user) #include? method :  변수에 저장안하고 디비내에서 바로 처리함
  # end


  def remove_ids # 매칭 성사가 되었던 유저들 id
    remove_ids = ["#{self.id}"]
    if self.friends.any?

    remove_ids << self.friends.ids

    end
    if self.pending_matchers.any?
    remove_ids << self.pending_matchers.ids 
    end

    if self.req_matchers.any?
      remove_ids << self.req_matchers.ids
    end
    remove_ids.join(",").split(",")
  end


  def first_login_today?

    updated_at < Time.now.midnight


  end


  def search_for_matcher(count = 2)


  matching_lan_user_ids = "Select user_id FROM languages
                      WHERE language = :user_matching_language"

   base_users = User.where("id IN (#{matching_lan_user_ids})" , 
    user_matching_language: matching_lan ).where.not(id: self.remove_ids).order("updated_at DESC")

   if (matching_age_from == nil || matching_age_to == nil) && matching_interest != nil  
   @valid_users = base_users.where("interests LIKE ?" , "%#{matching_interest}%").take(count)
   @matchers = create_for_matchers(@valid_users)
   
   
   elsif matching_age_from.present? && matching_age_to.present? && matching_interest == nil #나이 설정했을경우

    @valid_users = []

    base_users.each do |base_user|

      if @valid_users.count > count
       @matchers = create_for_matchers(@valid_users)
      elsif base_user.age && base_user.age >= matching_age_from &&  base_user.age <= matching_age_to
        @valid_users << base_user
      end


    end


    

   else #나이나 관심사 설정 안한 유저
  
   @valid_users = base_users.take(count)
   @matchers = create_for_matchers(@valid_users)

   end

   return  @matchers


  end




  def matchings_for_today

      today_matcher_ids = active_relationships.where(created_at: (Time.now.midnight..Time.now)).map(&:matched_id)

    if today_matcher_ids.any?
      @matchings = pending_matchers.where(id: today_matcher_ids).all 
    else
      @matchings = search_for_matcher

    end 


    if @matchings.nil?

      @matchings = []

    end 

    return @matchings
    
  end




   def age

    (Date.today - birthday).to_i / 365 if birthday.present?


   end


   def create_for_matchers(matchers)

     if matchers.count >= 2

        matchers.each do |matcher|

        active_relationships.build(matched_id: matcher.id).save
       end

     end
       
   end
  

  def friendship_for(other_user)
    friendships.find_by(friend_id: other_user.id)
  end


  def friend?(other_user)
    friends.include?(other_user)
  end

  def sayonara(other_user)
    if friend?(other_user)
      other_user.friendship_for(self).destroy
    end
    friendship_for(other_user).destroy
    
  end

  def was_requested_from?(other_user)
    other_user.pending_friends?(self)
  end

  def pending_friends?(other_user)
    @friendship = friendships.find_by(friend_id: other_user.id)
    @friendship && @friendship.status == "pending"
  end

  def ask_for_friends(other_user)
    friendships.create(friend_id: other_user.id, status: "pending") unless other_user.was_requested_from?(self)
  end

  def accept_friend_request(other_user)
    if friendships.create(friend_id: other_user.id, status: "friends", accepted_at: Time.now)
      @other_user_friendship = other_user.friendship_for(self)
      @other_user_friendship.update_attributes(status: "friends", accepted_at: Time.now)

    end
  end

 

  

  private

  def downcase_email
    self.email = email.downcase
  end


  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
    
  end


  end

 

