# Defines the common interface for search results based on a keyword
define ['backbone'], (Backbone) ->
  class SearchResult extends Backbone.Model
    
    # ------- TO SUBCLASS ----------
    
    # should reference the component to display the result
    # component: DetailComponent
    # searchComponent: SearchComponent

    # title

    # optionally fetch the full data needed to display
    # fetch: ->