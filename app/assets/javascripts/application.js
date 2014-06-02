// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function() {
  $('.all_households').click(function(e) {
    $('.all_households').hide();
    $('.hide_households').show();
    $('.old_household').fadeIn('slow');
    e.preventDefault();       
  })
})

$(document).ready(function() {
  $('.hide_households').click(function(e) {
    $('.hide_households').hide();
    $('.all_households').show();
    $('.old_household').fadeOut('slow');
    e.preventDefault(); 
  })
})


