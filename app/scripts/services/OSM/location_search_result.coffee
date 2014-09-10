# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'underscore',
  'jquery',
  'models/searches/search',
  'models/searches/search_result',
  'services/OSM/location_search_component',
  'services/OSM/location_detail_component',
  'q',
  ], (Backbone, _, $, Search, SearchResult, LocationSearchComponent, LocationDetailComponent, Q) ->
  Wikipedia =
    
  class LocationSearchResult extends SearchResult
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: LocationDetailComponent
    searchResultComponent: LocationSearchComponent
    
    title: ->
      "Title"

    lat: ->
      @get('lat')
    lng: ->
      @get('lng')

    zoomLevel: ->
      accuracy = ((+@get('lat')).toFixed(14)).replace(/^-?\d*\.?|0+$/g, '').length
      accuracy = ((+@get('lng')).toFixed(14)).replace(/^-?\d*\.?|0+$/g, '').length if ((+@get('lng')).toFixed(14)).replace(/^-?\d*\.?|0+$/g, '').length > accuracy
      zl = 4 + accuracy
      zl = 13 if zl > 13
      return zl

    initialize: ->

    fetch: ->
