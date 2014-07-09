define ['react', 'components/keyword_card', 'models/keyword_collection', 'underscore', 'utils/backbone_mixin', 'jquery', 'utils/pep'], (React, KeywordCard, KeywordCollection, _, BackboneMixin, $, pep) ->
  {div} = React.DOM
  MainComponent = React.createClass
    componentDidMount: ->
      $(@getDOMNode()).pep
        handle: '.erutpa-keyword-card-header'
        elementsWithInteraction: '.erutpa-keyword-card-canvas'
        useCSSTranslation: false
      domNode = $(@getDOMNode())
      $('body').on 'click.erutpa', (evt) =>
        @removeErutpa() unless domNode.has(evt.target).length > 0
 
    onClick: (evt) ->
      console.log 'main'
      evt.stopPropagation()
    mixins: [BackboneMixin]
    removeErutpa: ->
      @props.collection.reset []
    moveWindowIntoViewport: ->

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
    getInitialState: ->
      {}
    addKeyword: (keyword, evt) ->
      console.log evt
      @props.collection.add keyword: keyword
      if @props.collection.length == 1
        @moveComponentToMousePosition(evt)
    render: ->
      (div className: (if @props.collection.length > 0 then "show" else ""), id: "erutpa-main-component", onClick: @onClick, _.map(@props.collection.models, (keyword) ->
        (KeywordCard model: keyword)
        ))