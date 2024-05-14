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

  #Remaing User purpose 
  scope '/:client_id' do
    # User Sessions 
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
    # For Articles 
    resources :articles do 
      member do 
        post 'like', to:"likes#like"
        post 'dislike', to:"likes#dislike"
        get 'download'
      end
      # Article Preview Controller
      post 'approve_article', to: 'article_previews#publish_article'
      post 'reject_article', to: 'article_previews#reject_article'
      #Comments Controller 
      resources :comments, only:[:create, :destroy, :index, :new]
    end
    get '', to: 'articles#index', as:"client_articles"
    #Article Preview Controller
    get 'review_articles', to: 'article_previews#preview_articles', as:'review_articles'
    resources :client_users, only: [:new, :create, :index, :destroy]
    resources :article_assignments, only: [:new, :create]
    # Message Controller 
    resources :messages do 
      member do 
        post 'mark_as_read', to:'messages#mark_as_read'
      end
    end
    get 'all_messages', to: 'messages#all_messages'
  end
end