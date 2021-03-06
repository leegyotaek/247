Rails.application.routes.draw do
  
  get 'pictures/update'

  get 'meetings/index'

  get 'profiles/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

root 'static_pages#home'
get 'matching' => 'static_pages#matching'

get 'signup' => 'users#new'
get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'



get 'profile' => 'profiles#new'
post 'profile' => 'profiles#create'


resources :users do
 member do
  get :following, :followers
  post :accept
  get :friends
  post :request_matching
  post :enpending_matching
  post :accept_matching
  post :reject_matching


 end
end

resources :meetings do
  post :join
  post :disjoin


end
resources :account_activations, only: [:edit]
resources :password_resets, only: [:create, :new, :edit, :update]
resources :microposts, only:[:create, :destroy]
resources :relationships, only:[:create, :destroy]

resources :pictures, only:[:update]


resources :friendships, only:[:create, :destroy] 


 resources :conversations, only: [:index, :show, :new, :create] do
    

    member do
      post :reply
      post :trash
      post :untrash

    end
  end

  post 'mark_read'  => 'conversations#mark_read'
  post 'readable_off' => 'conversations#readable_off'
post 'search' => 'conversations#search'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
