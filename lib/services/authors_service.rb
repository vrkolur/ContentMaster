module Services 
    class AuthorsService

        def initialize(client: nil)
            @client = client
        end

        def authors_list
            authors = [] 
            @client.client_users.each do |author|
                if author.user.role.title=='Author'
                    authors.append(author)
                end
            end
            authors
        end

    end
end