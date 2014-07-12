# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'q',
  'components/searches/wikipedia_detail_component'
  ], (Backbone, $, Search, Q, WikipediaDetailComponent) ->
  Wikipedia =
    query: (q) ->
      deferred = Q.defer()

      $.getJSON "https://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        delete evt.query.pages["-1"]
        deferred.resolve _.values(evt.query.pages)

      deferred.promise

    parse: (link) ->
      deferred = Q.defer()
      console.log link
      title = link.match(/\/\/en.wikipedia.org\/wiki\/(.*)/)[1]
      console.log title
      $.getJSON "https://en.wikipedia.org/w/api.php?action=parse&format=json&page=#{escape(title)}&redirects=&prop=text&disableeditsection=", (evt) ->
        if evt.error
          deferred.reject evt.error
        else
          text = evt.parse.text["*"]
          text = text.replace /<a href="\/w/g, '<a href="//en.wikipedia.org/w'
          deferred.resolve text: text, title: title, link: link

      deferred.promise
  
  class WikipediaSearchResult extends Backbone.Model
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaDetailComponent
    initialize: ->
      @fetch()
    fetch: ->
      console.log 'fetch'
      unless @get('text')
        console.log 'actualt efecs'
        Wikipedia.parse @get('fullurl')
        .then (text) =>
          @set "text", text.text

  class WikipediaSearch extends Search
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    # component: "SearchResultComponent"
    
    searchResultModel: WikipediaSearchResult
    # should fetch the relevant information
    fetch: ->
      super()
      Wikipedia.query @get('keyword').get('keyword')
      .then (results) =>
        @searchResults.add results

    canHandleLink: (link) ->
      this

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      Wikipedia.parse link
      .then (article) ->
        searchResult = new WikipediaSearchResult article