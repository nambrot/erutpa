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
    searchComponent: LocationSearchComponent
    
    title: ->
      "Title"

    lat: ->
      return @attributes.dbpediaData.data["http://dbpedia.org/property/latitude"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/property/latitude"]
      return @attributes.dbpediaData.data["http://dbpedia.org/property/latD"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/property/latD"]
      return @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#lat"][0].value if @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#lat"]

      if @attributes.dbpediaData.data["http://dbpedia.org/property/latDegrees"]
        return (@attributes.dbpediaData.data["http://dbpedia.org/property/latDegrees"][0].value + @attributes.dbpediaData.data["http://dbpedia.org/property/latMinutes"][0].value / 60 + @attributes.dbpediaData.data["http://dbpedia.org/property/latSeconds"][0].value / 3600) * (if @attributes.dbpediaData.data["http://dbpedia.org/property/latDirection"][0].value is "N" then 1 else -1)
      return null
    lng: ->
      return @attributes.dbpediaData.data["http://dbpedia.org/property/longitude"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/property/longitude"]
      return @attributes.dbpediaData.data["http://dbpedia.org/property/longD"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/property/longD"]
      return @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#long"][0].value if @attributes.dbpediaData.data["http://www.w3.org/2003/01/geo/wgs84_pos#long"]
      if @attributes.dbpediaData.data["http://dbpedia.org/property/longDegrees"]
        return (@attributes.dbpediaData.data["http://dbpedia.org/property/longDegrees"][0].value + @attributes.dbpediaData.data["http://dbpedia.org/property/longMinutes"][0].value / 60 + @attributes.dbpediaData.data["http://dbpedia.org/property/longSeconds"][0].value / 3600) * (if @attributes.dbpediaData.data["http://dbpedia.org/property/longDirection"][0].value is "N" then 1 else -1)
      return null

    getZoomLevel: ->
      area = null
      area = @attributes.dbpediaData.data["http://dbpedia.org/property/area"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/property/area"]
      area = @attributes.dbpediaData.data["http://dbpedia.org/ontology/areaTotal"][0].value if @attributes.dbpediaData.data["http://dbpedia.org/ontology/areaTotal"]
      return Math.log(133315101.0 / Math.sqrt(area)) / Math.log(2) if area

      return 12 if _.any @attributes.dbpediaData.types, (type) -> ( _.contains ["http://dbpedia.org/ontology/Building","http://schema.org/LandmarksOrHistoricalBuildings","http://schema.org/StadiumOrArena","http://dbpedia.org/ontology/ArchitecturalStructure"], type)
      return 8
    zoomLevel: ->
      zL = parseInt @getZoomLevel()
      zL = 13 if zL and zL > 13
      zL = 1 if zL and zL < 1
      zL = 8 unless zL
      return zL

    initialize: ->

    fetch: ->
