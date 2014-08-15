define ['react', 'jquery'], (React, $) ->
  {div, article, header, section, p, ul, li, h2, span, video, source, iframe, a} = React.DOM
  VideoDetailComponent = React.createClass
    titleView: ->
      (span {}, (a href: @props.model.get('link'), @title()))
    title: ->
      "YouTube Video"
    render: ->
      (div className: "flex-video no-erutpa-subiew-padding", (iframe width:"100%", height:200, src: @props.model.getIframeUrl(), frameborder: 0, allowFullScreen: true))