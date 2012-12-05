(function() {

  define(["app"], function() {
    var Router;
    Router = Backbone.Router.extend({
      routes: {
        "": "start"
      },
      start: function() {
        return require(["modules/login"], function(Login) {
          return $(".container").append((new Login()).$el);
        });
      }
    });
    return Router;
  });

}).call(this);
