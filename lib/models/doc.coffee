class Doc extends Backbone.Model
  
  getTitle: ->
    @get('title')
    
  getThumbnailUrl: ->
    @get('cached_thumbnail')
    
  getLatitude: ->
    @get('geolat')

  getLongitude: ->
    @get('geolong')

  getThumbnail: ->
    if(@get('cached_thumbnail'))
      "http://www.culturegrid.org.uk/" + @get('cached_thumbnail')
      