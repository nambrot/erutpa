define [
  'backbone',
  'models/searches/search_result_collection',
  'models/searches/search_result',
  'models/searches/search',
  'components/search_component',
  'q',
  'services/wikipedia/wikipedia',
  'services/wikipedia/wikipedia_search_result'
  'services/wikipedia/wikipedia_search',
  'services/OSM/location_search_result'
  ], (Backbone, SearchResultCollection, SearchResult, Search, SearchComponent, Q, Wikipedia, WikipediaSearchResult, WikipediaSearch, LocationSearchResult) ->

  Freebase =
    query: (q) ->
      deferred = Q.defer()

      $.getJSON "https://www.googleapis.com/freebase/v1/search", query: q, stemmed: true, output: "(geocode key:/wikipedia/en_id description)", (evt) ->
        if evt.result.length > 0 and evt.result[0].score > 10
          deferred.resolve evt.result[0]
        else
          deferred.resolve null
      deferred.promise
    getNestedValue: (val) ->
      return _.values(val)[0][0] if _.values(val)[0] and _.values(val)[0][0]
      return null

  # Defines the common interface for search results based on a keyword
  class FreebaseSearch extends Search
        # ------- TO SUBCLASS ----------
    # should reference the component to display the result in a search list
    component: SearchComponent

    # an identifying class for customization
    canonicalCSSClass: 'erutpa-search'

    # specifies the canonical item
    searchResultModel: SearchResult

    # should fetch the relevant information
    fetch: ->
      return unless @fetchingStatus is "notYet"
      @fetching()
      Freebase
        .query(@keyword())
        .then (item) =>
          if wikipedia_id = Freebase.getNestedValue(item.output["key:/wikipedia/en_id"])
            Wikipedia
              .parseById wikipedia_id.match(/\/wikipedia\/en_id\/(.*)/)[1]
              .then (article) =>
                article.extract = _.values(item.output.description)[0][0]
                wikipediaSearchResult = new WikipediaSearchResult article
                @collection.addSearch(new WikipediaSearch({}, searchResults: [wikipediaSearchResult]), false, 0)
              .done()
          if location = Freebase.getNestedValue(item.output.geocode)
            locationSearchResult = new LocationSearchResult lat: parseFloat(location.latitude), lng: parseFloat(location.longitude), name: item.name
            @collection.addSearch new Search {}, searchResults: [locationSearchResult]
          @fetched()

    # should pattern match against the link, return false if can't, return self if it can
    canHandleLink: (link) ->
      false

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      false

