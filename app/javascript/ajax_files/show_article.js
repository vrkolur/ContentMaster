$(document).ready(function() {
    $('.commentsButton > button').click(function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        var cardDiv = $('.card');
        const clientId = cardDiv.data('client-name')
        const articleId = cardDiv.data('article-id')
        const url = `/${clientId}/articles/${articleId}/comments`;
        $.ajax({
            url: url,
            method: 'GET',
            data: $.param({article_id: articleId}),
            success: function (response) {
                var $response = $(response);
                var commentElements = $response.find('.comment');
                var allCommentsHtml = '';
                commentElements.each(function() {
                    allCommentsHtml += $(this).html();
                });
                $('.commentsContainer').html(allCommentsHtml);
            }
        });
    });
});