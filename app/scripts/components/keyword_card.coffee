define ['react', 'utils/backbone_mixin'], (React, BackboneMixin) ->
  {div, article, header, section, p, ul, li, h2, span} = React.DOM
  KeywordCard = React.createClass
    getInitialState: ->
      subviews: [(div className: 'erutpa-keyword-card-search-list', _.map(@props.model.searches.thatHaveResults(), (search) => 
                (search.component model: search, addSubview: @addSubview)
              )
            )]
    addSubview: (subview) ->
      # we have to wrap in a function to avoid it getting moounted earlier
      subview = subview()
      subviews = @state.subviews
      subviews.push subview
      @setState subviews: subviews
      return false
    popSubview: ->
      subviews = @state.subviews
      subviews.pop()
      @setState subviews: subviews
    mixins: [BackboneMixin]
    render: ->
      (article className: 'erutpa-keyword-card', [
        (header className: 'erutpa-keyword-card-header', [
          (span className: (if @state.subviews.length > 1 then "show back" else "back"), onClick: @popSubview),
          (h2 {}, @props.model.get('keyword'))
          ])
        (div className: 'erutpa-keyword-card-canvas', @state.subviews.map((subview, index) => 
            style = marginLeft: "-#{400 * (@state.subviews.length - 1)}px" if index is 0
            (div className: "erutpa-keyword-card-subview", style: style, subview)
          ))
      ])