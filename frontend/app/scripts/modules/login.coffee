define ["modules/baseView", "modules/user"], (View, User) ->

  View.extend
    template: "login"

    events:
      "click #login-button": "login"

    login: (e) ->
      e.preventDefault()
      user = new User
        username: $el.find("#username").val()
        password: $el.find("#password").val()

      auth = user.authenticate()
      if auth.err
        $el.find("#login-error").text(auth.err)