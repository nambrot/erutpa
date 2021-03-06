define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM

  WikipediaDetailComponent = React.createClass
    mixins: [BackboneMixin]
    titleView: ->
      (a href: @props.model.get('fullurl'), @props.model.get('title') )
    title: ->
      @props.model.get('title')
    render: ->
      if @props.model.get("text")
        (div className: 'erutpa-detail-component erutpa-wikipedia', dangerouslySetInnerHTML: {__html: @props.model.get("text")})
      else
        (div className: 'erutpa-detail-component erutpa-wikipedia', "Loading ...")