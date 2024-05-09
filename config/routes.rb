Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  
  #admin purpose only
  resources :clients do 
    member do 
      post 'change_client_active_status'
      get 'edit_sub_domain', to:'clients#edit_sub_domain'
      post 'update_sub_domain', to:'clients#update_sub_domain'
    end
  end

  #remaning purpose 
  scope '/:client_id' do
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
    resources :articles do 
      member do 
        post 'like'
        post 'dislike'
        get 'download'
      end
    post 'approve_article', to: 'articles#publish_article'
    resources :comments, only:[:create, :destroy, :index, :new]
    end
    get 'review_articles', to: 'articles#review_article', as: 'review_articles'
    resources :client_users, only: [:new, :create, :index, :destroy]
    resources :article_assignments, only:[:create]
  end
end
