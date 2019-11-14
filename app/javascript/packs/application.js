import "bootstrap";
import { Clipboard } from 'clipboard';

var btns = document.querySelectorAll('.clipboard-btn');
btns.forEach(function(btn){
    new Clipboard(btn); 
});
