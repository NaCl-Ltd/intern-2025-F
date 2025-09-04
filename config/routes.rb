Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :comments,            only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :microposts,          only: [:create, :destroy] do
    resource :likes, only: [:create, :destroy]
    collection do
      get :latest
    end
  end
  resources :users, only: [:index, :show]
  resources :microposts,  only: [:index, :show, :create] do
    resources :comments, only: [:create] do
      post :create
    end
  end

  resources :microposts do
    member do
      post :stick_on
      post :unpin_post
    end
  end

  resources :clubs, only: %i[index show]
  resources :matches, only: %i[index show] do
    resources :comments, only: [:create] do
      post :create
    end
    member do
      get :mom_results      # 集計表示
      post :close_votes     # 管理/ジョブ用
    end
    resources :votes, only: %i[new create update], module: :matches   # /matches/:match_id/votes
    resources :threads, only: %i[create], module: :matches        # matchスレ自動生成の手動補助
  end

  resources :threads, only: %i[index show create] do
    resources :microposts, only: %i[index create], module: :threads
  end
end
