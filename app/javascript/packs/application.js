import "bootstrap";
import { Clipboard } from 'clipboard';
console.log('<oi></oi>')
var btns = document.querySelectorAll('.clipboard-btn');
btns.forEach(function(btn){
    new Clipboard(btn); 
});
