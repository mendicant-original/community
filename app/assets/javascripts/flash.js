var Flash = {};

Flash.init = function(){
  setTimeout("$('div.flash').slideUp()", 2500);

  $('div.flash a.hide').click(function(e){
    $(this).parent('div.flash').slideUp();
    e.preventDefault();
  });
}