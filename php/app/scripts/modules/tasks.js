(function() {

  define(["app", "modules/baseView"], function(app, View) {
    var Collection, TaskModel, TaskView, TasksView;
    TaskModel = Backbone.Model.extend({
      url: function() {
        var url;
        url = "" + app.url + "/" + (this.get('user')) + "/tasks";
        if (!this.isNew()) {
          url += "/" + (this.get('id'));
        }
        return url;
      }
    });
    Collection = Backbone.Collection.extend({
      model: TaskModel,
      url: function() {
        return "" + app.url + "/" + this.user + "/tasks";
      }
    });
    TaskView = View.extend({
      tagName: "tr",
      template: "task",
      events: {
        "click .task-done": "cross",
        "click .remove": "remove",
        "dblclick .editable": "edit"
      },
      edit: function(e) {
        var $el, field, input,
          _this = this;
        $el = $(e.currentTarget);
        input = $("<input>", {
          type: "text",
          "class": $el.attr("class"),
          val: $el.text()
        });
        input.removeClass("editable");
        if ($el.hasClass("due-date")) {
          input.attr("type", "date");
          field = "dueDate";
        } else if ($el.hasClass("priority")) {
          input.attr({
            type: "number",
            min: 1,
            max: 10
          });
          field = "priority";
        } else {
          field = "description";
        }
        $el.replaceWith(input);
        input.focus();
        return input.on("blur", function() {
          var data;
          data = {};
          data[field] = input.val();
          return _this.model.save(data, {
            success: function(model) {
              return input.replaceWith($el.text(model.attributes[field]));
            },
            error: function() {
              if (xhr.responseText) {
                return _this.$el.parent().find(".error").text(JSON.parse(xhr.responseText).error);
              }
            }
          });
        });
      },
      remove: function() {
        this.$el.remove();
        return this.model.destroy();
      },
      cross: function(e) {
        return this.model.set("done", e.currentTarget.checked).save();
      }
    });
    return TasksView = View.extend({
      template: "tasks",
      events: {
        "click button#create-task": "createTask",
        "click #sort-by-due-date": function() {
          return this.sortBy("dueDate");
        },
        "click #sort-by-priority": function() {
          return this.sortBy("priority");
        },
        "click #logout": function() {
          return app.router.logout();
        }
      },
      serialize: function() {
        return this;
      },
      initialize: function(username, tasks) {
        var _this = this;
        if (tasks == null) {
          tasks = [];
        }
        this.user = username;
        this.model = new Collection(tasks);
        this.model.user = username;
        this.model.on("add", function(model) {
          return _this.table.append((new TaskView({
            model: model
          })).$el);
        });
        return this.render(function() {
          _this.table = _this.$el.find("tbody");
          if (tasks.length) {
            return _this.populate();
          }
        });
      },
      populate: function() {
        var _this = this;
        this.table.html("");
        return this.model.each(function(model) {
          return _this.table.append((new TaskView({
            model: model
          })).$el);
        });
      },
      createTask: function(e) {
        var task,
          _this = this;
        e.preventDefault();
        task = new TaskModel({
          description: this.$el.find("input.description").val(),
          dueDate: this.$el.find("input.due-date").val(),
          priority: this.$el.find("input.priority").val(),
          user: this.user
        });
        return task.save(null, {
          success: function() {
            return _this.model.add(task);
          },
          error: function(model, xhr) {
            if (xhr.responseText) {
              return _this.$el.find(".error").text(JSON.parse(xhr.responseText).error);
            }
          }
        });
      },
      sortBy: function(what) {
        var qs,
          _this = this;
        qs = "sortedBy=" + what;
        if (what === this.sortedBy) {
          qs += "&desc=true";
          this.sortedBy = "";
        } else {
          this.sortedBy = what;
        }
        return this.model.fetch({
          data: qs
        }).done(function() {
          return _this.populate();
        });
      }
    });
  });

}).call(this);
