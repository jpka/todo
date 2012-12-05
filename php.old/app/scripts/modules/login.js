(function() {

  define(["modules/baseView", "modules/user"], function(View, User) {
    return View.extend({
      template: "login",
      events: {
        "click #login-button": login
      },
      login: function(e) {
        var user;
        e.preventDefault();
        return user = new User({
          username: $el.find("#username").val(),
          password: $el.find("#password").val()
        });
      }
    });
  });

}).call(this);
