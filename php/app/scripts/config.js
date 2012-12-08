(function() {

  require.config({
    paths: {
      jquery: "../components/jquery/index",
      lodash: "../components/lodash/lodash",
      backbone: "../components/backbone/backbone",
      hamlCoffee: "vendor/hamlcoffee",
      text: "../components/text/text",
      coffeeScript: "vendor/coffee-script"
    },
    shim: {
      backbone: {
        deps: ["lodash", "jquery"],
        exports: "Backbone"
      },
      hamlCoffee: {
        deps: ["coffeeScript"],
        exports: function(cs) {
          window.CoffeeScript = cs;
          process.browser = true;
          return require("./hamlc");
        }
      }
    }
  });

}).call(this);
