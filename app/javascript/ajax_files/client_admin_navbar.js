// $(document).ready(function () {
//     const clientId = $(this).data('client-id');
//     // console.log(clientId);
//     $('#edit-sub-domain-button').click(function (e) { 
//       e.preventDefault;
//       $.ajax({
//         url: $(this).attr('href'),
//     method: 'GET',
//     dataType: 'script',
//     success: function(data) {
//       $('#edit-sub-domain-modal').show();
//     }
//   });
//     });
//   })

  $(document).ready(function () {
    var clientId; 
    $('#edit-sub-domain-button').click(function (e) { 
      e.preventDefault();
      clientId = $(this).data('client-id');

      $.ajax({
        url: $(this).attr('href'), 
        method: 'GET',
        success: function(data) {
          $('#edit-sub-domain-modal').show();
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.error(textStatus, errorThrown); 
        }
      });
    });
});



// $(document).ready(function () {
//     const clientId = $(this).data('client-id');
//     // console.log(clientId);
//     $('#save-sub-domain').click(function (e) { 
//       e.preventDefault();
//       var newSubDomain = $('#sub-domain-input').val();
//       // console.log(newSubDomain);
//     $.ajax({
//       url:`/clients/${<%=client.id%>}/update_sub_domain`,
//       method: 'POST',
//       data: {sub_domain: newSubDomain},
//       success: function(data) {
//         $('#client-sub-domain').html(newSubDomain) 
//         $('#edit-sub-domain-modal').hide();
//       }
//     });
//     });
//   })
$(document).ready(function () {
    $('#save-sub-domain').click(function (e) { 
      e.preventDefault();
      var newSubDomain = $('#sub-domain-input').val();
      var clientId = $(this).data('client-id'); // Retrieve the client ID from the data attribute

      $.ajax({
        url: `/clients/${clientId}/update_sub_domain`, // Use the client ID in the URL
        method: 'POST',
        data: { sub_domain: newSubDomain },
        success: function(data) {
          $('#client-sub-domain').html(newSubDomain);
          $('#edit-sub-domain-modal').hide();
        }
      });
    });
});
