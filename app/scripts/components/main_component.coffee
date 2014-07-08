define ['react', 'components/keyword_card', 'models/keyword_collection', 'underscore', 'utils/backbone_mixin'], (React, KeywordCard, KeywordCollection, _, BackboneMixin) ->
  {div} = React.DOM
  MainComponent = React.createClass
    mixins: [BackboneMixin]
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