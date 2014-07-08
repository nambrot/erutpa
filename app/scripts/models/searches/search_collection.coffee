define ['models/searches/search', 'models/searches/wikipedia_search', 'backbone'], (Search, WikipediaSearch, Backbone) ->
  class SearchCollection extends Backbone.Collection
    # keyword: "Keyword"
    initialize: (collection, options) ->
      super options
      @keyword = options.keyword if options.keyword

    model: Search

    thatHaveResults: ->
      _.where @models, (model) -> (model.searchResults.length > 1)

    searchDefault: ->
      @add new WikipediaSearch keyword: @keyword
      @each (model) -> model.fetch()