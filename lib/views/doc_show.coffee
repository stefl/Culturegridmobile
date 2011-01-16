class ShowDocView extends Backbone.View
  constructor: ->
    super
    
    # Get the active page from jquery mobile. We need to keep track of what this
    # dom element is so that we can refresh the page when the page is no longer active.
    @el = app.activePage()
    
    @template = _.template('''
      <div>
        
        <% if(doc.getThumbnail()) { %>
          <img src="<%= doc.getLargeImage() %>" />
        <% } %>
        
        <p>
          <%= doc.getDescription() %>
        </p>
        
        <ul data-role="listview" data-theme="d" data-inset="true" style="clear: both;">
        <% if(doc.getPartOf()) { %>
            <li data-role="list-divider">Part of</li>
    				<% _.each(doc.getPartOf(), function(part){ %>
            <li><%= part %></li>
            <% }); %>
       <% } %>
         
        
        <% if(doc.getContributors()) { %>
            <li data-role="list-divider">Contributors</li>
    				<% _.each(doc.getContributors(), function(contributor){ %>
            <li><%= contributor %></li>
            <% }); %>
        
       <% } %>
       
       <% if(doc.getLocation()) { %>
            <li data-role="list-divider">Location</li>
            <li><%= doc.getLocation() %></li>
       <% } %>
       
       <% if(doc.getRightsHolder()) { %>
           <li data-role="list-divider">Rights holder</li>
           <li><%= doc.getRightsHolder() %></li>
      <% } %>
      
       <% if(doc.getRelatedLink()) { %>
           <li data-role="list-divider">Related Link</li>
           <li><a href="<%= doc.getRelatedLink() %>">Visit</a></li>
      <% } %>
       </ul>
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