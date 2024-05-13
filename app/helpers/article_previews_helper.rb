module ArticlePreviewsHelper 
    def article_count_nil(articles)
        if articles.count==0
            yield
        end
    end
end