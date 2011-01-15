class ShowDocView extends Backbone.View
  constructor: ->
    super
    
    # Get the active page from jquery mobile. We need to keep track of what this
    # dom element is so that we can refresh the page when the page is no longer active.
    @el = app.activePage()
    
    @template = _.template('''
      <div>
        
        <p>
          <img style="width: 100%" src="<%= doc.getThumbnail() %>" />
        </p>
       
      </div>
    ''')
    
    # Watch for changes to the model and redraw the view
    @model.bind 'change', @render
    
    # Draw the view
    @render()
    
  render: =>
    # Set the name of the page
    @el.find('h1').text(@model.getTitle())
    
    # Render the content
    @el.find('.ui-content').html(@template({doc : @model}))

    # A hacky way of reapplying the jquery mobile styles
    app.reapplyStyles(@el)