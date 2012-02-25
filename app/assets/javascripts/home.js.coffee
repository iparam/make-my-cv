# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ -> 
  $('#signup-link').on "click", =>
    $(".login-form-div").hide()
    $(".signup-form-div").show()

  $('#login-link').on "click", =>
    $(".signup-form-div").hide()  
    $(".login-form-div").show()
