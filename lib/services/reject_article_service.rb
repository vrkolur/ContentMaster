module Services 
    class RejectArticleService 
        def initialize(article: nil,current_user: nil)
            @article = article
            @current_user = current_user
        end

        def reject_article
            @author = User.find_by(id: @article.client_user.user_id)
            msg = "Hey your article with title: #{@article.title} and Category: #{@article.category.title} has been rejected and destroyed by your Admin"
            @notification = Message.create(sender:@current_user, reciever:@author, msg: msg)
            @article.destroy
        end

    end
end