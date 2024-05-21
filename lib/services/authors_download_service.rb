module Services 
    class AuthorsDownloadService 
        def initialize(client=nil)
            @client = client 
        end

        def download()
            @authors = Services::AuthorsService.new(client: @client[:client]).authors_list
            authors_pdf = Prawn::Document.new
            authors_pdf.text @client[:client].name
            @authors.each do |client_user|
                author = User.find_by(id: client_user.user_id)
                ele = "#{author.name} -- #{author.email}"
                authors_pdf.text ele 
            end
            authors_pdf
        end
    end 
end 