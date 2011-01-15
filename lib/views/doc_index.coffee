class IndexDocView extends Backbone.View
  constructor: ->
    super
    
    @el = app.activePage()
    
    @template = _.template('''
      <div>
        
        <form action="#docs" method="post" id="search">

            <label>Find something:</label>
            <input type="text" value="<%= query %>" name="q" id="q" />
            <button type="submit" data-role="button">Search</button>
                      
        </form>
      
       <ul data-role="listview" data-inset="true">
          <% docs.each(function(doc){ %>
          <li><a href="#docs-<%= doc.cid %>"><%= doc.getTitle() %></a>
          <% if(doc.getThumbnail() != null) { %>
          <img src="<%= doc.getThumbnail() %>" />
          <% } %>
          </li>
          <% }); %>
       </ul>
      
      </div>
    ''')
    app.Docs.bind 'add', @render
    
    app.Docs.fetch({ success : @render })
        
    @render()
  
  events : {
    "submit form" : "onSubmit"
  }
  
  onSubmit: (e) ->
    console.log("submit")
    
    
    app.Docs = app.Docs.getByTerm($('#q').val())
    app.Docs.fetch({ success : @render })
    
    e.preventDefault()
    e.stopPropagation()
    
  render: =>
        
    # Render the content
    
    $('#search').submit( @onSubmit )
    console.log(app.Docs.query)
    @el.find('.ui-content').html(@template({docs : app.Docs, query : app.Docs.query }))
    app.Docs.invoke("bind", 'change', @render)
    # A hacky way of reapplying the jquery mobile styles
    app.reapplyStyles(@el)
    @delegateEvents()