define ['models/keyword', 'backbone'], (Keyword, Backbone) ->
  class KeywordCollection extends Backbone.Collection
    model: Keyword
    