define ['react', 'jquery'], (React, $) ->
  {div, article, header, section, p, ul, li, h2, span, video, source, iframe} = React.DOM
  VideoDetailComponent = React.createClass
    titleView: ->
      (span {}, @title())
    title: ->
      "Video"
    render: ->
      (div className: "flex-video no-erutpa-subiew-padding", dangerouslySetInnerHTML: {__html: "<iframe width='100%' height='200' src='#{@props.model.getIframeUrl()}'frameborder='0' allowfullscreen></iframe>"})