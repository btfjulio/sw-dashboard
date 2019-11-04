//= require rails-ujs
//= require_tree .
//= require clipboard

var btns = document.querySelectorAll('.clipboard-btn');
btns.forEach(btn => new Clipboard(btn));
  
