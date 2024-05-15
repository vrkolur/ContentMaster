$(() => {
    $("p.is-active > span").on("click", (event)=>{
      event.stopImmediatePropagation();
      const clientID = $(event.target).attr("data-client-id")
      // console.log(clientID);
      $.ajax({
        type: "post",
        url: `/clients/${clientID}/change_client_active_status`,
        success: function (response) {
          const txt = $(event.target).html();
          const res_txt = txt == "Yes" ? "No" : "Yes";
          $(event.target).html(res_txt);
        }
      });
    })
  });


$(document).ready(function () {
  $('.delete-client-bt').click(function(event){
    event.stopImmediatePropagation();
    var clientId = $(this).attr('data-client-id')
    // console.log(clientId); 
    $.ajax({
      url: "/clients/"+clientId,
      method: "DELETE",
      success: function (response) {
        // console.log(response);
      $('#client-card-'+clientId).remove();
      }
    });
  })
});
