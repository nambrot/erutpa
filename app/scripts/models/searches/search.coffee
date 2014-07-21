define [
  'backbone', 
  'models/searches/search_result_collection', 
  'models/searches/search_result',
  'components/search_component',
  ], (Backbone, SearchResultCollection, SearchResult, SearchComponent) ->

  # Defines the common interface for search results based on a keyword
  class Search extends Backbone.Model
    
    # keyword is accesible via @collection.keyword
    # set 'q' if you have a more specific keyword
    keyword: ->
      @get('q') || @collection.keyword.get('keyword')
    
    fetchingStatus: "notYet" # among ["notYet", "fetched", "fetching"]

    fetching: ->
      @fetchingStatus = "fetching"
      @trigger "fetching change"

    fetched: ->
      @fetchingStatus = "fetched"
      @trigger "fetched change"

    initialize: (attrs, options) ->
      options = options || {}
      super options
      searchResults = options.searchResults || []
      @searchResults = new SearchResultCollection searchResults, search: this
      , model: @searchResultModel
      @searchResults.on 'change reset add remove', =>
        @trigger 'change'


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
      # do the fetching
      @fetched()

    # should pattern match against the link, return false if can't, return self if it can
    canHandleLink: (link) ->
      false

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      false

