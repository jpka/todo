define ["app", "modules/login", "modules/tasks"], (app, Login, Tasks) ->

  Router = Backbone.Router.extend

    routes:
      "": "start"

    login: ->
      $("#content").html (new Login()).$el

    logout: ->
      $.getJSON "#{app.url}/logout", => @login()

    tasks: (user, tasks) ->
      $("#content").html (new Tasks(user, tasks)).$el

    start: ->
      $.ajax
        type: "POST"
        url: "#{app.url}/login"
        data: ""
        dataType: "json"
        success: (data) =>
          @tasks(data.username, data.tasks)
        error: =>
          @login()
