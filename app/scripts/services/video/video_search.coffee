# Defines the common interface for search results based on a keyword
define [
  'backbone',
  'jquery',
  'models/searches/search',
  'models/searches/search_result'
  'services/video/video_detail_component'
  'q'
  ], (Backbone, $, Search, SearchResult, VideoDetailComponent, Q) ->
    
    matchingRegex = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/

    class VideoSearchResult extends SearchResult
      # should reference the component to display the result
      component: VideoDetailComponent
      getIframeUrl: ->
        match = @get('link').match matchingRegex
        youtube_id = match[2] if match && (match[2].length is 11)
        "//www.youtube.com/embed/#{youtube_id}?autohide=1&controls=0"
      title: ->
        "Youtube Video"

    class VideoSearch extends Search
      
      # should reference the component to display the result
      # component: WikipediaSearchComponent
      # searchResultModel: WikipediaSearchResult
      canonicalCSSClass: 'erutpa-video'

      canHandleLink: (link) ->
        return this if link.match matchingRegex
        false

      # return false if not, searchResult if
      getSearchResultFromLink: (link) ->
        deferred = Q.defer()
        deferred.resolve new VideoSearchResult link: link
        deferred.promise