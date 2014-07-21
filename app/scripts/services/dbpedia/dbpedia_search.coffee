# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result',
  'services/OSM/location_search_result'
  'q',
  ], (Backbone, $, Search, SearchResult, LocationSearchResult, Q) ->
    Dbpedia =
      search: (q) ->
        deferred = Q.defer()
        $.getJSON "http://lookup.dbpedia.org/api/search/KeywordSearch?&QueryString=#{escape(q)}", (resp) ->
          deferred.resolve resp.results
        deferred.promise
      get: (url) ->
        deferred = Q.defer()
        console.log url
        $.getJSON url, (resp) ->
          deferred.resolve data: resp[url], types: resp[url]["http://www.w3.org/1999/02/22-rdf-syntax-ns#type"].map((val) -> (val.value))
        deferred.promise

    class DbpediaSearch extends Search
      fetch: ->
        Dbpedia
          .search( @keyword() )
          .then (searchResults) ->
            # for now, only pick the first one
            Dbpedia.get searchResults[0].uri
          .then (result) =>
            console.log result
            if result.types.indexOf("http://schema.org/Place") != -1
              console.log 'is a place'
              if @collection
                locationSearchResult = new LocationSearchResult dbpediaData: result
                @collection.addSearch(new Search {}, searchResults: [locationSearchResult])

