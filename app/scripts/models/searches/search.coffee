# Defines the common interface for search results based on a keyword
define [
  'backbone', 
  'models/searches/search_result_collection', 
  'components/searches/wikipedia_search_component',
  'models/searches/search_result'
  ], (Backbone, SearchResultCollection, WikipediaSearchComponent, SearchResult) ->
  class Search extends Backbone.Model
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaSearchComponent
    
    fetchingStatus: "notYet" # among ["notYet", "fetched"]

    searchResultModel: SearchResult

    initialize: (options) ->
      super options
      @searchResults = new SearchResultCollection [], search: this
      , model: @searchResultModel
      @searchResults.on 'change reset add remove', =>
        @trigger 'change'
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

