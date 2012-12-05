(function() {

  define(["modules/baseView", "modules/user"], function(View, User) {
    return View.extend({
      template: "login",
      events: {
        "click #login-button": "login"
      },
      login: function(e) {
        var auth, user;
        e.preventDefault();
        user = new User({
          username: $el.find("#username").val(),
          password: $el.find("#password").val()
        });
        auth = user.authenticate();
        if (auth.err) {
          return $el.find("#login-error").text(auth.err);
        }
      }
    });
  });

}).call(this);
