define ["app", "modules/baseView"], (app, View) ->

  TaskModel = Backbone.Model.extend
    url: ->
      url = "#{app.url}/#{@get('user')}/tasks"
      url += "/#{@get('id')}" unless @isNew()
      url

  Collection = Backbone.Collection.extend
    model: TaskModel

    url: ->
      "#{app.url}/#{@user}/tasks"

  TaskView = View.extend
    tagName: "tr"
    template: "task"

    events:
      "click .task-done": "cross"
      "click .remove": "remove"
      "dblclick .editable": "edit"

    edit: (e) ->
      $el = $(e.currentTarget)
      input = $ "<input>",
        type: "text"
        class: $el.attr "class"
        val: $el.text()

      input.removeClass "editable"

      if $el.hasClass "due-date"
        input.attr "type", "date"
        field = "dueDate"
      else if $el.hasClass "priority"
        input.attr
          type: "number"
          min: 1
          max: 10
        field = "priority"
      else
        field = "description"
      $el.replaceWith input

      input.focus()
      input.on "blur", =>
        data = {}
        data[field] = input.val()
        @model.save data,
          success: (model) ->
            input.replaceWith $el.text(model.attributes[field])
          error: =>
            @$el.parent().find(".error").text(JSON.parse(xhr.responseText).error) if xhr.responseText

    remove: ->
      @$el.remove()
      @model.destroy()

    cross: (e) ->
      @model.set("done", e.currentTarget.checked).save()

  TasksView = View.extend
    template: "tasks"

    events:
      "click button#create-task": "createTask"
      "click #sort-by-due-date": -> @sortBy "dueDate"
      "click #sort-by-priority": -> @sortBy "priority"
      "click #logout": -> app.router.logout()

    serialize: -> @

    initialize: (username, tasks = []) ->
      @user = username
      @model = new Collection(tasks)
      @model.user = username
      @model.on "add", (model) =>
        @table.append (new TaskView({model: model})).$el
      
      @render =>
        @table = @$el.find("tbody")
        if tasks.length
          @populate()

    populate: ->
      @table.html ""
      @model.each (model) =>
        @table.append (new TaskView({model: model})).$el

    createTask: (e) ->
      e.preventDefault()

      task = new TaskModel
        description: @$el.find("input.description").val()
        dueDate: @$el.find("input.due-date").val()
        priority: @$el.find("input.priority").val()
        user: @user

      task.save null,
        success: =>
          @model.add task
        error: (model, xhr) =>
          @$el.find(".error").text(JSON.parse(xhr.responseText).error) if xhr.responseText

    sortBy: (what) ->
      qs = "sortedBy=#{what}"
      if what is @sortedBy
        qs += "&desc=true"
        @sortedBy = ""
      else
        @sortedBy = what

      @model.fetch
        data: qs
      .done =>
        @populate()
