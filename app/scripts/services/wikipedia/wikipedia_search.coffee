# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'services/wikipedia/wikipedia_detail_component',
  'services/wikipedia/wikipedia_search_component'
  ], (Backbone, $, Search, SearchResult, Q, WikipediaDetailComponent, WikipediaSearchComponent) ->
  Wikipedia =
    query: (q) ->
      deferred = Q.defer()

      $.getJSON "https://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        delete evt.query.pages["-1"]
        deferred.resolve _.values(evt.query.pages)

      deferred.promise

    parse: (link) ->
      deferred = Q.defer()
      title = link.match(/\/\/en.wikipedia.org\/wiki\/(.*)/)[1]
      $.getJSON "https://en.wikipedia.org/w/api.php?action=parse&format=json&page=#{escape(title)}&redirects=&prop=text&disableeditsection=", (evt) ->
        if evt.error
          deferred.reject evt.error
        else
          text = evt.parse.text["*"]
          text = text.replace /<a href="\/w/g, '<a href="//en.wikipedia.org/w'
          deferred.resolve text: text, title: title, fullurl: link

      deferred.promise
  
  class WikipediaSearchResult extends SearchResult
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaDetailComponent
    title: ->
      @get('title')
    initialize: ->
      @fetch()
    fetch: ->
      unless @get('text')
        Wikipedia.parse @get('fullurl')
        .then (text) =>
          @set "text", text.text

  class WikipediaSearch extends Search
    
    # should reference the Keyword
    # keyword: "Independence Day"
    
    # should reference the component to display the result
    component: WikipediaSearchComponent
    searchResultModel: WikipediaSearchResult
    canonicalCSSClass: 'erutpa-wikipedia'

    # should fetch the relevant information
    fetch: ->
      @fetching()
      Wikipedia.query @collection.keyword.get('keyword')
      .then (results) =>
        @searchResults.add results
      .fin =>
        @fetched()

    canHandleLink: (link) ->
      return this if link.match /\/\/en\.wikipedia\.org\/wiki\//
      false

    # return false if not, searchResult if
    getSearchResultFromLink: (link) ->
      Wikipedia.parse link
      .then (article) ->
        searchResult = new WikipediaSearchResult article