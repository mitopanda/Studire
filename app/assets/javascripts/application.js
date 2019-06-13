// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

// formの文字数のカウンター
$(document).on("turbolinks:load", function() {
  $("#profile-count").on("keydown keyup keypress change", function() {
    var countNum = $(this).val().length;
    $("#user-counter").text(countNum + "文字");
    console.log(countNum);
    if (countNum > 200) {
      $("#user-counter").removeClass("count-default");
      $("#user-counter").addClass("count-danger");
    } else {
      $("#user-counter").removeClass("count-danger");
      $("#user-counter").addClass("count-default");
    }
  });
});

$(document).on("turbolinks:load", function() {
  $("#post-count").on("keydown keyup keypress change", function() {
    var count = $(this).val().length;
    $("#post-counter").text(count + "文字");
    console.log(count);
    if (count > 50) {
      $("#post-counter").removeClass("count-default");
      $("#post-counter").addClass("count-danger");
    } else {
      $("#post-counter").removeClass("count-danger");
      $("#post-counter").addClass("count-default");
    }
  });
});

//  フォローボタンのテキスト変更
$(function() {
  $(".unfollow-button")
    .mouseover(function() {
      $(this).attr("value", "フォロー解除");
    })
    .mouseout(function() {
      $(this).attr("value", "フォロー中");
    });
});
