$(document).ready(function(){

  $.each($(':checked'), function( index, value ) {
    $(value).parent().addClass('active');
  });

  $('.ui.button').on('click', function(){
    $(this).toggleClass('active');
    var $this_checkbox = $(this).children();
    if ($this_checkbox.is(':checked')){
      $this_checkbox.prop('checked', false);
    } else {
      $this_checkbox.prop('checked', true);
    }
  });

  $('.check').on('click', function(){
    $(this).parent().toggleClass('active');
  });

});