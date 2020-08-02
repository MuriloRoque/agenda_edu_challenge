$(document).on('turbolinks:load',function (){
  // remove unread class when user click on message
  $('.view_message').on('click', function(e){
    $(this).parent().parent().removeClass('unread')
  });

    // Make tr redirect on click
  $(".clickable").click(function(e) {
    if($(e.target).hasClass('not_clickable')){

    } else {
      window.location = $(this).find('.view_message').attr('href');
    }


  });

   // Make tr redirect on click
  $(".clickable_user").not('.not_clickable').click(function() {
    window.location = $(this).data('href');
  });

  // Show ticket for user
  $('#see_token').on('click',function(){
    $('#token').show();
    $(this).hide();
  })
});

