Filter = {};

Filter.init = function(field, path){
  this.field = '#' + field;
  this.path  = path;

  $(this.field).bind('search', function(e){
    Filter.update();
  }).keyup(function(e){
    Filter.update();
  });
}

Filter.update = function(){
  $.get(Filter.path, {
    filter: $(Filter.field).val()
  });
}