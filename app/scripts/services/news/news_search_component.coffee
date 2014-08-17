define ['react', 'utils/backbone_mixin', 'underscore', 'services/images/image_detail_component', 'services/images/image_search_grid_component', 'components/iframe_component'], (React, BackboneMixin, _, ImageDetailComponent, ImageSearchGridComponent, IframeComponent) ->
  {div, article, header, section, p, ul, li, h5, h6, a, img, span, footer} = React.DOM

  NewsSearchListComponent = React.createClass
    title: ->
      "News for #{@props.model.keyword()}"
    titleView: ->
      (span {}, @title())
    render: ->
      (div className: "erutpa-news-list-component", @props.model.searchResults.map (searchResult) =>
        (NewsSearchResultComponent model: searchResult)
        )

  NewsSearchResultComponent = React.createClass
    mixins: [BackboneMixin]
    imageComponent: ->
      if @props.model.get('enclosures') then (img src: @props.model.get("enclosures")[0].uri) else (span {})
    onClick: ->
      @props.addSubview _.bind(IframeComponent, this, title: @props.model.get("title"), href: @props.model.get('url'))
      return false
    render: ->
      (article className: 'erutpa-news-search-result-item', onClick: @onClick, [
        (div className: "erutpa-news-thumbnail", style: { backgroundImage: "url(#{@props.model.get("enclosures")[0].uri})" }) if @props.model.get('enclosures') unless @props.titleOnly
        (h6 className: "#{if @props.titleOnly then "onlyTitle" else ""}", (a href: @props.model.get('url'), @props.model.get("title"))),
        (h5 {}, "#{@props.model.get("source")} - #{@props.model.get("parsed_date").fromNow()}"),
        (p className: 'clamp-3', @props.model.get("summary")) unless @props.titleOnly
        ])

  NewsSearchComponent = React.createClass
    mixins: [BackboneMixin]
    onCardClick: ->
      @props.addSubview _.bind(NewsSearchListComponent, this, model: @props.model, addSubview: @props.addSubview)
      return false
    imageComponent: ->
      if @props.model.searchResults.model[0].get('enclosures') then (img src: @props.model.searchResults.model[0].get("enclosures")[0].uri) else (span {})
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-news", onClick: @onCardClick, [
        (h5 className:'erutpa-keyword-card-search-card-title', "News for #{@props.model.keyword()}"),
        (NewsSearchResultComponent model: @props.model.searchResults.models[0], addSubview: @props.addSubview)
        (NewsSearchResultComponent model: @props.model.searchResults.models[1], titleOnly: true, addSubview: @props.addSubview) if @props.model.searchResults.models[1]
        (NewsSearchResultComponent model: @props.model.searchResults.models[2], titleOnly: true, addSubview: @props.addSubview) if @props.model.searchResults.models[2]
        (footer {}, (a {}, "and #{@props.model.searchResults.length - 3} more")) if @props.model.searchResults.length > 3
        ]) 