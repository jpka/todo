require ["config", "app", "router"], (config, app, Router) ->

  app.router = new Router()

  Backbone.history.start()
    #pushState: true

  $.ajaxSetup({cache:false})

  # // All navigation that is relative should be passed through the navigate
  # // method, to be processed by the router. If the link has a `data-bypass`
  # // attribute, bypass the delegation completely.
  $(document).on "click", "a[href]:not([data-bypass])", (evt) ->
    # // Get the absolute anchor href.
    href = { prop: $(this).prop("href"), attr: $(this).attr("href") }
    # // Get the absolute root.
    root = location.protocol + "//" + location.host + app.root

    # // Ensure the root is part of the anchor href, meaning it's relative.
    if href.prop.slice(0, root.length) == root
      # // Stop the default event to ensure the link will not cause a page
      # // refresh.
      evt.preventDefault()

      # // `Backbone.history.navigate` is sufficient for all Routers and will
      # // trigger the correct events. The Router's internal `navigate` method
      # // calls this anyways.  The fragment is sliced from the root.
      Backbone.history.navigate href.attr, true