# Defines the common interface for search results based on a keyword
define ['backbone'], (Backbone) ->
  class SearchResult extends Backbone.Model
    
    # ------- TO SUBCLASS ----------
    
    # should reference the component to display the result
    # component: "SearchResultComponent"

    # optionally fetch the full data needed to display
    # fetch: ->