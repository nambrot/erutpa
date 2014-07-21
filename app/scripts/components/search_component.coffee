define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM

  WikipediaSearchComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div className: "erutpa-keyword-card-search-card #{@props.model.canonicalCSSClass}", @props.model.searchResults.map (searchResult) =>
        (searchResult.searchComponent model: searchResult, addSubview: @props.addSubview)
        )