define [
  'backbone', 
  'models/searches/search_result_collection', 
  'models/searches/search_result'
  ], (Backbone, SearchResultCollection, SearchResult) ->

  # Defines the common interface for search results based on a keyword
  class Search extends Backbone.Model
    
    # keyword is accesible via @collection.keyword
    
    # should reference the component to display the result in a search list
    # component: Component
    
    fetchingStatus: "notYet" # among ["notYet", "fetched"]

    initialize: (options) ->
      super options
      @searchResults = new SearchResultCollection [], search: this
      , model: @searchResultModel
      @searchResults.on 'change reset add remove', =>
        @trigger 'change'


    # ------- TO SUBCLASS ----------
    # specifies the canonical item
    searchResultModel: SearchResult

    # should fetch the relevant information
    fetch: ->
      return if @fetchingStatus is "fetched"
      @fetchingStatus = "fetched"

    # should pattern match against the link, return false if can't, return self if it can
    canHandleLink: (link) ->
      false

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      false

