$(function (){
  $('.datepicker').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  $('*[rel~="twipsy"]').twipsy({live: true});
  $('*[rel~="twipsy"]').live('ajax:before', function(){
    $(this).twipsy('hide');
  });

  $('.bigtext').each(function() {
    var fontsize = parseInt($('.bigtext').css('font-size'));
    $(this).bigtext({maxfontsize: fontsize});
  });
});

$('a[data-submit]').live('click', function(e){
  var form = $(this).attr('data-submit');
  $('#' + form).submit();

  $(this).attr('disabled', true);

  e.preventDefault();
});
