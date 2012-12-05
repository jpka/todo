(function() {

  define(["app", "hamlCoffee"], function(app, hamlc) {
    return Backbone.View.extend({
      append: function(tag, params) {
        var el;
        el = $("<" + tag + ">", params);
        this.$el.append(el);
        return el;
      },
      render: function() {
        var _this = this;
        if (this.template != null) {
          return $.get("/templates/" + this.template + ".hamlc", function(template) {
            return _this.$el.html(hamlc.compile(template)(_this.model));
          });
        }
      },
      initialize: function() {
        return this.render();
      }
    });
  });

}).call(this);
