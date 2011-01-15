app.Docs = new DocCollection().getByTerm("soon")
app.docController = new DocController()

$(document).ready ->
  
  Backbone.history.start()
  app.docController.index()
    
@app = app