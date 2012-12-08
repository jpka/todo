define ["app", "modules/baseView", "modules/tasks"], (app, View, Tasks) ->

  View.extend
    tagName: "form"
    id: "login-form"
    template: "login"

    events:
      "click #login-button": (e) -> 
        e.preventDefault()
        @login()
      "click #register-button": (e) ->
        e.preventDefault()
        @login(true)

    login: (registerFirst) ->
      $.ajax
        cache: false
        url: "#{app.url}/" + if registerFirst then "register" else "login"
        dataType: "json"
        data: @$el.serialize()
        error: (xhr) =>
          @showError JSON.parse(xhr.responseText).error if xhr.responseText
        success: (data) =>
          @$el.replaceWith (new Tasks(data.username, data.tasks)).$el

    showError: (error) ->
      @$el.find("#login-error").text error