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
$(function() {
  $("#profile-text").keyup(function() {
    var count = $(this).val().length;
    if (count <= 200) {
      $("#counter").removeClass("profile-count-danger");
      $("#counter").addClass("profile-count-default");
      $("#counter").text(count + "文字");
    } else if (count > 200) {
      $("#counter").text(count + "文字");
      $("#counter").removeClass("profile-count-default");
      $("#counter").addClass("profile-count-danger");
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
