// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require tinymce-jquery
//= require_tree .

$(function() {
  toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "7000",
    "hideDuration": "3000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };

  $(".form-ajax").on("ajax:success", function(e, data, status, xhr){
    _message = data.message;
    if(_message !== undefined){
      toastr.success(_message);
    }
  }).on("ajax:error", function(e, xhr, status, error){
    resp = $.parseJSON(xhr.responseText);
    _message = resp.message;
    if(_message !== undefined){
      toastr.error(_message);
    }
  }).on("ajax:complete", function(e, xhr, settings){
    resp = $.parseJSON(xhr.responseText);
    _location = resp.location;
    if(_location !== undefined && _location.length > 0 ){
      $(location).attr('href', _location);
    }
    _prepend_content = resp.prepend_content;
    if(_prepend_content !== undefined){
      $prepend = $($(".form-ajax").data("prepend-el"));
      $(_prepend_content).prependTo($prepend).hide().slideDown( "slow");
    }
  });
});