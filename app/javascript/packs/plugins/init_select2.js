import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

const initSelect2 = () => {
  $('.select2').select2({
    placeholder: "Select an option",
  }); // (~ document.querySelectorAll)
};

const createInputStores = (data) => {
  let options = data.stores.map(store => `<option value="${store}">${store}</option>`).join('')
  let input = `<option value=""></option>
                ${options}
                </select>
              </div>`
  document.getElementById("seller").innerHTML  = input
  // $('#created-form').select2();
}

const callApiStores = (data) => {
  fetch(`https://cors-anywhere.herokuapp.com/https://savewhey-api.herokuapp.com/api/v1/stores/${data}?user_email=btfjulio@hotmail.com&user_token=x6nZcxz9jyaR68y3GEsy`)
  .then(response => response.json())
  .then((data) => {
    console.log(data)
    createInputStores(data);
  })
}

const select = document.querySelector('#store-query');
// select.addEventListener('change', (event) => {
//   callApiStores(event.currentTarget.value);
// });


export { initSelect2 };