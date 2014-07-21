# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result',
  'services/OSM/location_search_component',
  'services/OSM/location_detail_component',
  'q',
  ], (Backbone, $, Search, SearchResult, LocationSearchComponent, LocationDetailComponent, Q) ->
  Wikipedia =
    
  class LocationSearchResult extends SearchResult
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: LocationDetailComponent
    searchComponent: LocationSearchComponent
    
    title: ->
      "Title"

    lat: ->
      @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#lat"][0].value
    lng: ->
      @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#long"][0].value

    initialize: ->

    fetch: ->
