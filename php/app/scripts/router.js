(function() {

  define(["app", "modules/login", "modules/tasks"], function(app, Login, Tasks) {
    var Router;
    return Router = Backbone.Router.extend({
      routes: {
        "": "start"
      },
      login: function() {
        return $("#content").html((new Login()).$el);
      },
      logout: function() {
        var _this = this;
        return $.getJSON("" + app.url + "/logout", function() {
          return _this.login();
        });
      },
      tasks: function(user, tasks) {
        return $("#content").html((new Tasks(user, tasks)).$el);
      },
      start: function() {
        var _this = this;
        return $.ajax({
          type: "POST",
          url: "" + app.url + "/login",
          data: "",
          dataType: "json",
          success: function(data) {
            return _this.tasks(data.username, data.tasks);
          },
          error: function() {
            return _this.login();
          }
        });
      }
    });
  });

}).call(this);
