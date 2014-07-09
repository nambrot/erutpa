# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search'
  ], (Backbone, $, Search) ->
  Wikipedia =
    query: (q, callback) ->
      $.getJSON "https://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        delete evt.query.pages["-1"]
        callback _.values(evt.query.pages)
    parse: (title, callback) ->
      $.getJSON "https://en.wikipedia.org/w/api.php?action=parse&format=json&page=#{escape(title)}&redirects=&prop=text&disableeditsection=", (evt) ->
        callback evt.parse.text["*"]
  
  class WikipediaSearchResult extends Backbone.Model
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: "SearchResultComponent"
    initialize: ->
      @fetch()
    fetch: ->
      Wikipedia.parse @get('title'), (text) =>
        @set "text", text
        console.log this
  class WikipediaSearch extends Search
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    # component: "SearchResultComponent"
    
    searchResultModel: WikipediaSearchResult
    # should fetch the relevant information
    fetch: ->
      super()
      Wikipedia.query @get('keyword').get('keyword'), (results) =>
        @searchResults.add results
