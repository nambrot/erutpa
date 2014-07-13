define ['models/searches/search', 'services/wikipedia/wikipedia_search', 'backbone'], (Search, WikipediaSearch, Backbone) ->
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
      @add new WikipediaSearch
      @each (model) -> model.fetch()