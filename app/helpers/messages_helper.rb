module MessagesHelper
    def message_count_nil(messages) 
        if messages.count==0 
            yield 
        end
    end
end
