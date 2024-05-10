module ArticlesHelper

    def article_image_attached(article)
      if article.image.attached?
        yield
      end
    end
  
    def current_user_role_admin(user,client)
      if (user.role.title == 'ClientAdmin' || user.role.title == 'Author') && belongs_to_same_client(user,client)
        yield
      end
    end
  
    def article_form_errors(article)
      if article&.errors.any?
        yield
      end
    end
  
    def tags_present(tags)
      if tags
        yield
      end
    end
  
    def article_published(article)
      if article&.status 
        yield 
      end
    end
  
    def article_to_be_published(article)
      if !article&.status 
        yield 
      end
    end

    def user_present(user)
      if user 
        yield 
      end
    end

    def user_not_preesent(user)
      unless user 
        yield 
      end
    end

    def belongs_to_same_client(user,client)
      return ClientUser.find_by(user: user)&.client == client
    end
  
  end
  