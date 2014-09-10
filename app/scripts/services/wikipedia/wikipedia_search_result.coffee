# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'services/wikipedia/wikipedia_detail_component',
  'services/wikipedia/wikipedia_search_component',
  'services/dbpedia/dbpedia_search',
  'services/images/image_search',
  'services/wikipedia/wikipedia'
  ], (Backbone, $, Search, SearchResult, Q, WikipediaDetailComponent, WikipediaSearchComponent, DbpediaSearch, ImageSearch, Wikipedia) ->
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