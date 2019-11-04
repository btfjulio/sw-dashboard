//= require rails-ujs
//= require_tree .
//= require clipboard

const btns = document.querySelectorAll('.clipboard-btn');
btns.forEach(btn => new Clipboard(btn));
  
