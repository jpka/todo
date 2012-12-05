(function() {

  define(["app"], function(app) {
    return Backbone.Model.extend({
      url: "/api/user",
      authenticate: function(cb) {
        if (!this.isValid()) {
          return cb({
            err: "User and/or password missing"
          });
        } else {
          return $.ajax({
            type: "POST",
            url: "" + this.url + "/authenticate",
            data: this.attrs,
            dataType: "json",
            success: cb
          });
        }
      }
    });
  });

}).call(this);
