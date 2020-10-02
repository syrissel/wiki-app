// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("tinymce").start()

window.jQuery = $;
window.$ = $;

require("@rails/ujs").start()
global.Rails = Rails;
require("turbolinks").start()
require("@rails/activestorage").start()
require('@client-side-validations/client-side-validations')
require('custom/image-form-validations')
require('custom/notifications')
require('jquery-scroll-lock/jquery-scrollLock')
require('custom/search')
// require('custom/bootstrap_sidebar')
require('custom/custom_sidebar')
import "channels";
import "jquery";
import "boxicons";
import "custom/side_menu";
import "custom/header";
import 'custom/wiki-validate';



//import '@client-side-validations/client-side-validations'
//import "custom/image_show";
//import "custom/kaminari"


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
