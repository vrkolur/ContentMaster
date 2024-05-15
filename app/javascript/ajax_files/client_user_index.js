$(document).ready(function() {
    $('.btn-danger').on('click', function(e) {
      e.preventDefault(); // Prevent the default form submission
  
      var clientName = $(this).data('client-name'); 
      var authorId = $(this).data('author-id'); 
        $.ajax({
          url: `/${clientName}/client_users/${authorId}`, 
          type: 'DELETE',
          success: function() {
            $('tr[data-author-id="' + authorId + '"]').remove();
          },
          error: function() {
            alert('An error occurred. Please try again.');
          }
        });
    });
  });