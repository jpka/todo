define ["app", "hamlCoffee"], (app, hamlc)->

  Backbone.View.extend
    #className: "row"

    append: (tag, params) ->
      el = $("<#{tag}>", params)
      @$el.append el
      el

    serialize: ->
      if @model?
        @model.attributes
      else
        @

    render: (cb) ->
      if @template?
        $.get "app/templates/#{@template}.hamlc", (template) =>
          @$el.html hamlc.compile(template)(@serialize())
          cb() if cb

    initialize: ->
      @render()