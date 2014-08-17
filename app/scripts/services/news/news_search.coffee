define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'components/search_result_component',
  'components/search_component',
  'services/news/news_search_component',
  'moment'
  ], (Backbone, $, Search, SearchResult, Q, SearchResultComponent, SearchComponent, NewsSearchComponent) ->

  News = 
    search: (q) ->
      deferred = Q.defer()
      $.getJSON "http://api.feedzilla.com/v1/articles/search.json?q=#{escape q}&since=#{moment().subtract(2,'w').format("YYYY-MM-DD")}", (evt) ->
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
    areArticlesUpToDate: (articles) ->
      articles = _.map articles, (article) -> _.extend article, parsed_date: moment(article.publish_date), time_difference: moment().diff moment(article.publish_date)

      upToDate = moment().subtract(_.chain articles
      .sortBy (article) -> article.time_difference
      .first 5
      .reduce ((sum, article) -> (sum.add article.time_difference)), moment.duration()
      .value()).isAfter moment().subtract(25, 'd')
      
      [upToDate, articles]
    fetch: ->
      @fetching()
      News.search @keyword()
      .then (articles) =>
        [upToDate, articles] = @areArticlesUpToDate (articles)
        if upToDate
          @searchResults.add articles
        @fetched()
      .done()