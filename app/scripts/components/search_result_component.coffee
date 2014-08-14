define ['react'], (React) ->
  {div, article, header, section, p, ul, li, h2, span} = React.DOM
  SearchListComponent = React.createClass
    titleView: ->
      (span {}, @title())
    title: ->
      "SearchResultComponent"
    render: ->
      (div {}, "SearchResultComponent")