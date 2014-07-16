define ['models/searches/search', 'services/default_searches', 'backbone'], (Search, defaultSearches, Backbone) ->
  class SearchCollection extends Backbone.Collection
    # gets initialized with keyword
    # keyword: Keyword
    initialize: (collection, options) ->
      super options
      @keyword = options.keyword if options.keyword

    model: Search

    thatHaveResults: ->
      _.filter @models, (model) -> (model.searchResults.length > 0)

    thatStillFetch: ->
      _.filter @models, (model) -> (model.fetchingStatus == "fetching")

    searchDefault: ->
      defaultSearches.forEach (search) => 
        @add new search
      @each (model) -> model.fetch()