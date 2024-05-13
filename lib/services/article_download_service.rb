module Services 
    class ArticleDownloadService
        def initialize(article: nil)
            @article = article
        end

        def download 
            article_pdf = Prawn::Document.new
            article_pdf.text  @article.title
            image_attachment = @article.image
            if image_attachment.image?
                image_data = image_attachment.download
                article_pdf.move_down 10
                article_pdf.image StringIO.new(image_data), fit: [200, 200], position: :center
            end
            article_pdf.text @article.category.title
            article_pdf.text @article.body
            
            article_pdf
        end
    end
end