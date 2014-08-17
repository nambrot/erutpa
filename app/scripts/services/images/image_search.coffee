define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'q',
  'components/search_result_component',
  'services/images/image_search_component',
  'services/wikipedia/wikipedia'
  ], (Backbone, $, Search, SearchResult, Q, SearchResultComponent, ImageSearchComponent, Wikipedia) ->

  class ImageSearchResult extends SearchResult
    searchResultComponent: SearchResultComponent
    component: SearchResultComponent
    title: ->
      @get('canonicaltitle')
    thumbnail: (width) ->
      url = @get('url').replace(/\/commons\//, "/commons/thumb/") + "/#{width}px-" + @get('url').split('/')[@get('url').split('/').length-1]
      url += '.png' if url.split('.')[url.split('.').length-1] is 'svg'
      return url
  class ImageSearch extends Search

    # should reference the Keyword
    # keyword: "Independence Day"

    # should reference the component to display the result
    component: ImageSearchComponent
    searchResultModel: ImageSearchResult
    canonicalCSSClass: 'erutpa-images'

    # should fetch the relevant information
    fetch: ->
      @fetching()
      Wikipedia.getImages(@keyword())
      .then (images) =>
        if images.length > 0
          @searchResults.add images
        @fetched()