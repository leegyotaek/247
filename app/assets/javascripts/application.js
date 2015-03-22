//= require webcomponentsjs/webcomponents.min
//= require jquery.min
//= require jquery_ujs
//= require jquery.Jcrop
//= require pictures
//= require turbolinks

$(function() {
  var faye = new Faye.Client('/faye');
  faye.subscribe('/matching', function (data) {
    alert(data);
  });
});
