class DocController extends Backbone.Controller
  routes :
    "docs" : "index"
    "docs-:cid" : "show"
    "search-:term" : "search"

  constructor: ->
    super
    @_views = {}
  
  index: ->
    @_views["docs"] ||= new IndexDocView { docs : app.Docs}
    
  show: (cid) ->
    @_views["docs-#{cid}"] ||= new ShowDocView { model : app.Docs.getByCid(cid) }

  search: (term) ->
    @_views["search-#{term}"] ||= new IndexDocView { docs : app.Docs.getByTerm(term)}
