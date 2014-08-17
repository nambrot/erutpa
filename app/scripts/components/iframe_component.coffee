define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, h6, a, img, span, footer, iframe} = React.DOM
  IFrameComponent = React.createClass
    title: ->
      @props.title
    titleView: ->
      (a href: @props.href, @title())
    render: ->
      (iframe className: "no-erutpa-subiew-padding", src: @props.href, style: {width: '100%', height: 500})