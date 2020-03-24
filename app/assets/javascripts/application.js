//= require rails-ujs
//= require_tree 
//= require clipboard

var btns = document.querySelectorAll('.clipboard-btn');
btns.forEach(function(btn){
    new Clipboard(btn); 
});
  
