//= require rails-ujs
//= require_tree .
//= require clipboard

var btns = document.querySelectorAll('.clipboard-btn');
btns.forEach((btn), function(btn){
    new Clipboard(btn); 
});
  
