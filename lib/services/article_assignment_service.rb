module Services 
    class ArticleAssignmentService 
        def initialize(params: nil, current_user: nil)
            @params = params 
            @current_user = current_user
        end

        def create
            if check_params
                @author = User.find_by(id: @params[:author_id])
                msg = "Hey you are supposed to create a artile with title:#{params[:title]} and Category: #{Category.find_by(id: params[:category_id]).title} "
                @notification = Message.create(sender: @current_user, reciever: @author,msg: msg)
            else 
                return nil 
            end
        end

        def check_params
            unless @params[:author_id].nil? && @params[:title].nil? && @params[:category_id].nil? && @current_user.nil? 
                return false
            end
            return true
        end
    end
end