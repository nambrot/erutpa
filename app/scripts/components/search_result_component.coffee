define ['react', 'components/search_result_detail_component'], (React, SearchResultDetailComponent) ->
  {div, article, header, section, p, ul, li, h2, span} = React.DOM
  SearchListComponent = React.createClass
    onClick: ->
      @props.addSubview _.bind(SearchResultDetailComponent, this, model: @props.model)
      return false
    render: ->
      (div onClick: @onClick, "SearchResultComponent")