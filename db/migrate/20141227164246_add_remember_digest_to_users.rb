class AddRememberDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remeber_digest, :string
  end
end
