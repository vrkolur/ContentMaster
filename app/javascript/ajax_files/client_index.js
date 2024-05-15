$(document).ready(function () {
    $('#close-modal-btn').click(function () {
       $.ajax({
       url: "/clients",
       method: "GET",
       success: function (response) {
          $('.client-container').html(response)
       }
       });
    })
 });