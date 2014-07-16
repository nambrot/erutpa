define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h2, span} = React.DOM
  SearchListComponent = React.createClass
    mixins: [BackboneMixin]
    titleView: ->
      if @props.model.searches.thatStillFetch().length > 0
        (span {}, "Searching for #{@props.model.get('keyword')}")
      else
        (span {}, "Search Results for #{@props.model.get('keyword')}")
    title: ->
      @props.model.get 'keyword'
    render: ->
      searchesWithResults = @props.model.searches.thatHaveResults()
      if searchesWithResults.length > 0
        (div className: "erutpa-keyword-card-search-list", searchesWithResults.map (search) => 
                (search.component model: search, addSubview: @props.addSubview)
        )
      else
        if @props.model.searches.thatStillFetch().length > 0
          (div className: 'erutpa-keyword-card-search-list', "Searching ...")
        else
          (div className: 'erutpa-keyword-card-search-list', "Nothing Found")