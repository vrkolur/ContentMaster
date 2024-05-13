    // /:client_id/articles/:id/like
    $(document).ready(function() {
        $('.like-button').click(function(e) {
          e.preventDefault();
          e.stopImmediatePropagation();
          var articleId = $(this).data('article-id');
          var userId = $(this).data('user-id');
          var txtValue = $(e.target).html();
          // var clientId = $(e.targte).data('client-name');
          var clientId = $(this).data('client-name')
          console.log(clientId);
          var dislike_value = $(e.target).siblings('button').html();
          $.ajax({
            type: 'POST',
            url: `/${clientId}/articles/${articleId}/like`,
            success: function(response) {
            if(dislike_value == 'Disliked 👎'){
              $(e.target).siblings('button').html('Dislike')
            }
            res_txt_value = txtValue == 'Liked 👍' ? 'Like ' : 'Liked 👍'
            $(e.target).html(res_txt_value)
            }
          });
        });
      });
    
        $(document).ready(function() {
            $('.dislike-button').click(function(e) {
          e.preventDefault();
          e.stopImmediatePropagation();
          var articleId = $(this).data('article-id');
          var userId = $(this).data('user-id');
          var txtValue_dislike = $(e.target).html();
          var clientId = $(this).data('client-name');
          var like_value = $(e.target).siblings('button').html();
          $.ajax({
            url: `/${clientId}/articles/${articleId}/dislike`,
            type: 'POST',
            success: function(response) {
                if(like_value == 'Liked 👍'){
                  $(e.target).siblings('button').html('Like')
                }
                res_txt_value = txtValue_dislike == 'Disliked 👎' ? 'Dislike' : 'Disliked 👎'
                $(e.target).html(res_txt_value)
            }
          });
        });
      });
    
    //  POST   /:client_id/articles/:article_id/approve_article
      $(document).ready(function() {
      $('.approve-button').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        var articleId = $(this).data('article-id');
        var clientName = $(this).data('client-name');
        $.ajax({
          url: `/${clientName}/articles/${articleId}/approve_article`,
          type: 'POST',
          data: {id: articleId},
          success: function(response) {
            $('div.card[data-article-id="' + articleId + '"]').remove();
            // console.log(response);
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.error(textStatus, errorThrown);
          }
        });
      });
    });
    //Reject the article
      $(document).ready(function() {
      $('.reject-button').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        var articleId = $(this).data('article-id');
        var clientName = $(this).data('client-name');
        $.ajax({
          url: `/${clientName}/articles/${articleId}/reject_article`,
          type: 'POST',
          data: {id: articleId},
          success: function(response) {
            $('div.card[data-article-id="' + articleId + '"]').remove();
          },
          error: function(jqXHR, textStatus, errorThrown) {
            console.error(textStatus, errorThrown);
          }
        });
      });
    });