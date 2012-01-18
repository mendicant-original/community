var Flash = {};

Flash.init = function(){
  setTimeout("$('div.flash').removeClass('bounceIn').addClass('fadeOut')", 2500);
}