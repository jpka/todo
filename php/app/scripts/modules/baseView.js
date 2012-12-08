(function() {

  define(["app", "hamlCoffee"], function(app, hamlc) {
    return Backbone.View.extend({
      append: function(tag, params) {
        var el;
        el = $("<" + tag + ">", params);
        this.$el.append(el);
        return el;
      },
      serialize: function() {
        if (this.model != null) {
          return this.model.attributes;
        } else {
          return this;
        }
      },
      render: function(cb) {
        var _this = this;
        if (this.template != null) {
          return $.get("app/templates/" + this.template + ".hamlc", function(template) {
            _this.$el.html(hamlc.compile(template)(_this.serialize()));
            if (cb) {
              return cb();
            }
          });
        }
      },
      initialize: function() {
        return this.render();
      }
    });
  });

}).call(this);
