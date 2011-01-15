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
    else
      null
  
  getContributors: ->
    @get('dc.contributor')
    
  getRightsHolder: ->
    @get('dcterms.rightsHolder')
    
  getIdentifierUrl: ->
    @get('dc.identifier')
  
  getDescription: ->
    @get('dc.description')
    
  getRelatedLink: ->
    @get('dc.related.link')
  
  getLicense: ->
    @get('dcterms.license')
  
  getLocation: ->
    @get('dc.location')
        
  getPartOf: ->
    @get('dcterms.isPartOf_Name')
    