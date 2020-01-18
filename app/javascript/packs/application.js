import "bootstrap";
import { initSelect2 } from "./plugins/init_select2"

const refreshStatus = () => {
    let list = document.querySelectorAll('.saudi_choice')
    list.forEach((dropdown) => {
      dropdown.addEventListener('change',(e) => {
        e.currentTarget.closest('form').submit();
      })
    })
  }
  
refreshStatus();
initSelect2();