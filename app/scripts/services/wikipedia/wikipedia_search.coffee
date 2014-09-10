# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'services/wikipedia/wikipedia_detail_component',
  'services/wikipedia/wikipedia_search_component',
  'services/dbpedia/dbpedia_search',
  'services/images/image_search',
  'services/wikipedia/wikipedia',
  'services/wikipedia/wikipedia_search_result'
  ], (Backbone, $, Search, SearchResult, Q, WikipediaDetailComponent, WikipediaSearchComponent, DbpediaSearch, ImageSearch, Wikipedia, WikipediaSearchResult) ->

  class WikipediaSearch extends Search
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaSearchComponent
    searchResultModel: WikipediaSearchResult
    canonicalCSSClass: 'erutpa-wikipedia'

    # should fetch the relevant information
    fetch: ->
      return unless @fetchingStatus is "notYet"
      return if @fetchingStatus is "fetched"
      @fetching()
      Wikipedia.query @collection.keyword.get('keyword')
      .then (results) =>
        @searchResults.add results
        # if @searchResults.length > 0 and @collection and @collection.keyword?
        #   dbpedia_search = new DbpediaSearch q: @searchResults.at(0).title()
        #   image_search = new ImageSearch q: @searchResults.at(0).title()
        #   @collection.addSearch dbpedia_search
        #   @collection.addSearch image_search
      .fin =>
        @fetched()

    canHandleLink: (link) ->
      return this if link.match /\/\/en\.wikipedia\.org\/wiki\//
      false

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      Wikipedia.parse link
      .then (article) ->
        searchResult = new WikipediaSearchResult article