$(document).ready(function () {
    $('.btn.btn-primary').click(function (e) { 
        e.preventDefault();
        clickedButton = this;
        var clientName = $(this).data('client-name');
        var messageId = $(this).data('message-id');
        $.ajax({
            url: `/${clientName}/messages/${messageId}/mark_as_read`,
            method: 'POST',
            success: function (response) {
                 $(clickedButton).closest('.card').remove(); 
                alert('Message marked as read and removed.');
            }
        });
    });
});
