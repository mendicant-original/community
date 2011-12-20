var Flash = {};

Flash.init = function(){
  setTimeout("$('div.flash').fadeOut()", 2500);

  $('div.flash').mouseover(function(e){
    $(this).fadeOut();
  });
}