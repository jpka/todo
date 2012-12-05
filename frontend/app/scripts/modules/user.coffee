define ["app"], (app) ->

  Backbone.Model.extend
    url: "#{app.url}api/user"

    authenticate: (cb) ->
      if !@isValid()
        cb {err: "User and/or password missing"}
      else
        $.ajax
          type: "POST"
          url: "#{@url}/authenticate"
          data: @attrs
          dataType: "json"
          success: cb
