var Flash = {};

Flash.init = function(){
  setTimeout("$('div.flash').slideUp()", 2500);

  $('div.flash').mouseover(function(e){
    $(this).slideUp();
  });
}