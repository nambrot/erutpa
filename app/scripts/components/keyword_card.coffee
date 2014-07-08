define ['react', 'utils/backbone_mixin'], (React, BackboneMixin) ->
  {div, article, header, section, p, ul, li} = React.DOM
  KeywordCard = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (article className: 'erutpa-keyword-card', [
        (header className: 'erutpa-keyword-card-header', @props.model.get('keyword')),
        (div className: 'erutpa-keyword-card-canvas', 
          (div className: 'erutpa-keyword-card-search-list', _.map(@props.model.searches.thatHaveResults(), (search) -> 
              (search.component model: search)
            )
          )
        )
      ])