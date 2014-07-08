define ['react', 'components/keyword_card', 'models/keyword_collection', 'underscore', 'utils/backbone_mixin', 'jquery', 'utils/pep'], (React, KeywordCard, KeywordCollection, _, BackboneMixin, $, pep) ->
  {div} = React.DOM
  MainComponent = React.createClass
    componentDidMount: ->
      $(@getDOMNode()).pep
        handle: '.erutpa-keyword-card-header'
        elementsWithInteraction: '.erutpa-keyword-card-canvas'
        useCSSTranslation: false
      $('body').on 'click.erutpa', =>
        @removeErutpa()
      $('body').on 'click.erutpa', '#erutpa-main-component', (evt) ->
        evt.stopPropagation()
    mixins: [BackboneMixin]
    removeErutpa: ->
      @props.collection.reset []
    getDefaultProps: ->
      collection: new KeywordCollection([])
    getInitialState: ->
      x: this.props.x || 0
      y: this.props.y || 0
    addKeyword: (keyword) ->
      @props.collection.add keyword: keyword
    render: ->
      (div className: (if @props.collection.length > 0 then "show" else ""), id: "erutpa-main-component", _.map(@props.collection.models, (keyword) ->
        (KeywordCard model: keyword)
        ))