define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h2, span} = React.DOM
  SearchListComponent = React.createClass
    mixins: [BackboneMixin]
    titleView: ->
      searchesWithResults = @props.model.searches.thatHaveResults()
      if searchesWithResults.length > 0
        (span {}, "Search Results for #{@props.model.get('keyword')}")
      else
        (span {}, "Searching for #{@props.model.get('keyword')}")
    render: ->
      searchesWithResults = @props.model.searches.thatHaveResults()
      if searchesWithResults.length > 0
        (div className: "erutpa-keyword-card-search-list", searchesWithResults.map (search) => 
                (search.component model: search, addSubview: @props.addSubview)
        )
      else
        (div className: 'erutpa-keyword-card-search-list', "Searching ...")
