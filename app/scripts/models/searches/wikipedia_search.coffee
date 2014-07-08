# Defines the common interface for search results based on a keyword
define ['backbone', 'jquery', 'models/searches/search'], (Backbone, $, Search) ->
  Wikipedia =
    query: (q, callback) ->
      # http://en.wikipedia.org/w/api.php?action=query&titles=Vietnam&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100
      $.getJSON "http://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        callback _.values(evt.query.pages)

  class WikipediaSearch extends Search
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    # component: "SearchResultComponent"
    
    # should fetch the relevant information
    fetch: ->
      super()
      Wikipedia.query @get('keyword').get('keyword'), (results) =>
        @searchResults.add results
