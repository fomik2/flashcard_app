// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require turbolinks
//= require_tree .

 
$(function() { 

// Таймер для расчета качества ответа (quality)
  if($("#timer_value").length > 0) {
    var counter = 0;
    var timer = setInterval(function() { 
                  $("#timer_value").val(counter++);
                  if (counter >= 60) clearInterval(timer); 
                }, 1000);
  }
})
