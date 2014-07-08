# Defines the common interface for search results based on a keyword
define ['backbone'], (Backbone) ->
  class SearchResult extends Backbone.Model
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: "SearchResultComponent"