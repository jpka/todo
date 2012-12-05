define ["app"], ->

  Router = Backbone.Router.extend

    routes:
      "": "start"

    start: () ->
      require ["modules/login"], (Login) ->
        $(".container").append (new Login()).$el

  Router
