(function() {

  define(["app"], function() {
    var Router;
    Router = Backbone.Router.extend({
      routes: {
        "": "start"
      },
      start: function() {
        return require(["modules/library"], function(Library) {
          return $(".container").append((new Library.View()).$el);
        });
      }
    });
    return Router;
  });

}).call(this);
