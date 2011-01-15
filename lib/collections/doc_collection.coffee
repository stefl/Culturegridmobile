class DocCollection extends Backbone.Collection
  model : Doc
  url : "http://culturegridapp.heroku.com/search?q=happy&page=1&per_page=10"
  query : ""
  
  getByTerm: (query) ->
    
    d = new DocCollection()
    d.url = "http://culturegridapp.heroku.com/search?q=" + query + "&page=1&per_page=10"
    d.query = query
    d