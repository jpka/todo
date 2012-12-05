define ["app", "hamlCoffee"], (app, hamlc)->

  Backbone.View.extend
    #className: "row"

    append: (tag, params) ->
      el = $("<#{tag}>", params)
      @$el.append el
      el

    render: ->
      if @template?
        $.get "app/templates/#{@template}.hamlc", (template) =>
          @$el.html hamlc.compile(template)(@model)

    initialize: ->
      @render()