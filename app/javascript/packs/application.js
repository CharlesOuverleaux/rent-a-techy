// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import { initFlatpickr } from "../plugins/flatpickr";
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

const fetchNotifications = async () => {
  const res = await fetch("/notifications")
  const notifications = await res.json()
  // console.log(notifications)

  const noti_con = document.getElementById('notifications_con')
  let innerHTML = ''
  notifications.forEach((noti) => {
    const color = noti.msg.includes("confirmed") ? 'notification_success' : 'notification_fail'
    innerHTML += `<div class="notification_con ${color}" onclick="this.remove()"><div>${noti.msg}</div><div>X</div></div>`
  })
  // console.log(innerHTML)
  // console.log(noti_con)
  noti_con.innerHTML = innerHTML
}


document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();

  initFlatpickr();

  // infinite check for notifications
  setInterval(fetchNotifications, 5000);
});