$(document).on('turbolinks:load', function () {
  $('#add-form').on('click', function(e){
    var count = $('.hide-form');
    var form = $('.hide-form').first();

    if(count.length==0){
      $('#add-form').hide();
    } else if(count.length==1){
      form.show();
      form.removeClass('hide-form');
      form.addClass('appear-form');
      $('#add-form').hide();
    } else{
      form.show();
      form.removeClass('hide-form');
      form.addClass('appear-form');
    }
  });
});
