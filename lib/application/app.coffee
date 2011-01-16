app.Docs = new DocCollection().getByTerm("painting")
app.docController = new DocController()

$(document).ready ->
  
  Backbone.history.start()
  app.docController.index()
    
@app = app