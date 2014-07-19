define [
  'backbone', 
  'models/searches/search_result_collection', 
  'models/searches/search_result'
  ], (Backbone, SearchResultCollection, SearchResult) ->

  # Defines the common interface for search results based on a keyword
  class Search extends Backbone.Model
    
    # keyword is accesible via @collection.keyword
    
    
    
    fetchingStatus: "notYet" # among ["notYet", "fetched", "fetching"]

    fetching: ->
      @fetchingStatus = "fetching"
      @trigger "fetching change"

    fetched: ->
      @fetchingStatus = "fetched"
      @trigger "fetched change"

    initialize: (options) ->
      super options
      @searchResults = new SearchResultCollection [], search: this
      , model: @searchResultModel
      @searchResults.on 'change reset add remove', =>
        @trigger 'change'


    # ------- TO SUBCLASS ----------

    # should reference the component to display the result in a search list
    # component: Component

    # an identifying class for customization
    canonicalCSSClass: ''

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

