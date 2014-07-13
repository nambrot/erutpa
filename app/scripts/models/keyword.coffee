define ['backbone', 'models/searches/search_collection'], (Backbone, SearchCollection) ->

  # keyword has mulitples searches via search_collection
  # keyword_component renders searches that have at least one SearchResult via Search's search_results
  class Keyword extends Backbone.Model

    initialize: (options) ->
      super options
      @setup()
      
    setup: ->
      @searches =  new SearchCollection [], keyword: this
      @searches.on 'change reset add remove', =>
        @trigger 'change'
      @fetch()

    resetKeyword: (keyword) =>
      @set 'keyword', keyword
      @setup()
      
    # fetch relevant data
    fetch: ->
      @searches.searchDefault() 


