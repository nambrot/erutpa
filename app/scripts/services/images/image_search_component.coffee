define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM
  WikipediaSearchComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-images", [
        (h5 className:'erutpa-keyword-card-search-card-title', "Images for #{@props.model.keyword()}"),
        (div className: 'erutpa-images-strip', style: {height: 100}, @props.model.searchResults.map (searchResult) =>
          (img src: searchResult.get('thumburl'), width: searchResult.get('thumbwidth'), height: searchResult.get('thumbheight'))
          )
        ]) 