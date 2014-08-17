define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'components/search_result_component',
  'components/search_component',
  'services/news/news_search_component'
  ], (Backbone, $, Search, SearchResult, Q, SearchResultComponent, SearchComponent, NewsSearchComponent) ->

  News = 
    search: (q) ->
      deferred = Q.defer()
      $.getJSON "http://api.feedzilla.com/v1/articles/search.json?q=#{escape q}", (evt) ->
        deferred.resolve evt.articles
      deferred.promise

  class NewsSearch extends Search

    # should reference the Keyword
    # keyword: "Independence Day"

    # should reference the component to display the result
    component: NewsSearchComponent
    # searchResultModel: ImageSearchResult
    canonicalCSSClass: 'erutpa-news'

    # should fetch the relevant information
    fetch: ->
      @fetching()
      News.search @keyword()
      .then (articles) =>
        @searchResults.add articles
        @fetched()
      .done()