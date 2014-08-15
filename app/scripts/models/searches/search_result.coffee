# Defines the common interface for search results based on a keyword
define ['backbone', 'components/search_result_component'], (Backbone, SearchResultComponent) ->
  class SearchResult extends Backbone.Model
    
    # ------- TO SUBCLASS ----------
    
    # should reference the component to display the result
    # component: DetailComponent
    searchResultComponent: SearchResultComponent

    # title

    # optionally fetch the full data needed to display
    # fetch: ->