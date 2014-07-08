# Defines the common interface for search results based on a keyword
define [
  'backbone', 
  'models/searches/search_result_collection', 
  'components/searches/wikipedia_search_component'
  ], (Backbone, SearchResultCollection, WikipediaSearchComponent) ->
  class Search extends Backbone.Model
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaSearchComponent
    
    fetchingStatus: "notYet" # among ["notYet", "fetched"]

    initialize: (options) ->
      super options
      @searchResults = new SearchResultCollection [], search: this
      @searchResults.on 'change reset add remove', =>
        @trigger 'change'
    # should fetch the relevant information
    fetch: ->
      return if @fetchingStatus is "fetched"
      @fetchingStatus = "fetched"
