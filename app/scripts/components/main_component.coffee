define [
  'react',
  'components/keyword_card',
  'models/keyword_collection',
  'underscore',
  'utils/backbone_mixin',
  'jquery',
  'utils/pep',
  'services/default_searches'
  ], (React, KeywordCard, KeywordCollection, _, BackboneMixin, $, pep, DefaultSearches) ->
  {div, span} = React.DOM
  MainComponent = React.createClass
    mixins: [BackboneMixin]

    #detect external clicks
    componentDidMount: ->
      $(@getDOMNode()).pep
        handle: '.erutpa-keyword-card-header'
        elementsWithInteraction: 'input'
        useCSSTranslation: false
      domNode = $(@getDOMNode())
      $('body').on 'click.erutpa', (evt) =>
        @removeErutpa() unless domNode.has(evt.target).length > 0
        true

      @eruptifyLinks()

    getHandlingSearchFromLink: (link) ->
      _.chain DefaultSearches
        .map (search) -> ( new search().canHandleLink(link) )
        .find (val) -> (val)
        .value()
    eruptifyLink: (link, search) ->
      return if $(link).data('eruptified')
      $(link).append "<span class='eruptified #{search.canonicalCSSClass}'>&nbsp;</span>"
      $(link).on 'click.erutpa', '.eruptified', (evt) =>
        search.getSearchResultFromLink link.href
        .then (searchResult) =>
          @addSearchResult searchResult, evt
        #if getting searchResult fails, go to link
        return false
      $(link).data 'eruptified', true

    eruptifyLinks: ->
      $('body:not(#erutpa-main-component) a:not(:has(*))').each (idx, val) =>
        search = @getHandlingSearchFromLink val.href
        @eruptifyLink(val, search) if search
    removeErutpa: ->
      @props.collection.reset []
      return false

    #move component into view port, ideally close to mouse position
    moveComponentToMousePosition: (evt) ->
      windowWidth = $(window).width()
      mouseX = evt.pageX
      mouseY = evt.pageY
      scrollTop = $('body').scrollTop()
      componentWidth = 400
      if mouseX + componentWidth > windowWidth - 40
        # we are too right
        left = mouseX - componentWidth
        if left < 10
          left = 10
      else
        left = mouseX + 10
      $(@getDOMNode()).css left: left, top: scrollTop + 30

    getDefaultProps: ->
      collection: new KeywordCollection([])

    addSearchResult: (searchResult, evt) ->
      @props.collection.add keyword: searchResult.title(), initialSubviews: [new searchResult.component model: searchResult]
      @moveComponentToMousePosition(evt)

    addKeyword: (keyword, evt) ->
      lS = if localStorage["erutpaKeywords"] then localStorage["erutpaKeywords"].split(',') else []
      lS.push keyword
      localStorage["erutpaKeywords"] = lS.join(',')
      @props.collection.add keyword: keyword
      if @props.collection.length == 1
        @moveComponentToMousePosition(evt)
    
    render: ->
      (div className: (if @props.collection.length > 0 then "show" else ""), id: "erutpa-main-component", _.map(@props.collection.models, (keyword) ->
        (KeywordCard model: keyword, initialSubviews: keyword.get('initialSubviews'), keyword: keyword.get('keyword'))
        ).concat((span className: 'erutpa-main-component-close-button', onClick: @removeErutpa, 'X')))