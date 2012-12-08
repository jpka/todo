(function() {

  define(["app", "modules/baseView", "modules/tasks"], function(app, View, Tasks) {
    return View.extend({
      tagName: "form",
      id: "login-form",
      template: "login",
      events: {
        "click #login-button": function(e) {
          e.preventDefault();
          return this.login();
        },
        "click #register-button": function(e) {
          e.preventDefault();
          return this.login(true);
        }
      },
      login: function(registerFirst) {
        var _this = this;
        return $.ajax({
          type: "POST",
          url: ("" + app.url + "/") + (registerFirst ? "register" : "login"),
          dataType: "json",
          data: this.$el.serialize(),
          error: function(xhr) {
            if (xhr.responseText) {
              return _this.showError(JSON.parse(xhr.responseText).error);
            }
          },
          success: function(data) {
            return _this.$el.replaceWith((new Tasks(data.username, data.tasks)).$el);
          }
        });
      },
      showError: function(error) {
        return this.$el.find("#login-error").text(error);
      }
    });
  });

}).call(this);
