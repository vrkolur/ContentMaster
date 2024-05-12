Rails.application.routes.draw do
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
        # post 'like'
        # post 'dislike'
        post 'like', to:"likes#like"
        post 'dislike', to:"likes#dislike"
        get 'download'
      end
      # post 'approve_article', to: 'articles#publish_article'
      post 'approve_article_new', to: 'article_previews#publish_article_new'
      post 'reject_article', to: 'article_previews#reject_article'
      resources :comments, only:[:create, :destroy, :index, :new]
    end
    get 'author_notifications', to:"article_previews#all_notifications", as: "author_notifications"
    get '', to: 'articles#index', as:"client_articles"
    # get 'review_articles', to: 'articles#review_article', as: 'review_articles'
    get 'review_articles_new', to: 'article_previews#preview_articles', as:'review_articles_new'
    resources :client_users, only: [:new, :create, :index, :destroy]
    resources :article_assignments, only: [:new, :create]
  end
end
