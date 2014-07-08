define ['models/searches/search_result', 'backbone'], (SearchResult, Backbone) ->
  class SearchResultCollection extends Backbone.Collection
    # search: Search
    initialize: (options) ->
      super options
      @search = options.search if options.search

    model: SearchResult
