define ['react', 'utils/backbone_mixin', 'underscore', 'services/images/image_detail_component', 'services/images/image_search_grid_component'], (React, BackboneMixin, _, ImageDetailComponent, ImageSearchGridComponent) ->
  {div, article, header, section, p, ul, li, h5, a, img, span} = React.DOM
  ImageSearchComponent = React.createClass
    mixins: [BackboneMixin]
    onCardClick: ->
      @props.addSubview _.bind(ImageSearchGridComponent, this, model: @props.model, addSubview: @props.addSubview)
      return false
    onImgClick: (model) ->
      @props.addSubview _.bind(ImageDetailComponent, this, model: model)
      return false
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-images", onClick: @onCardClick, [
        (h5 className:'erutpa-keyword-card-search-card-title', "Images for #{@props.model.keyword()}"),
        (div className: 'erutpa-images-strip', style: {height: 100}, @props.model.searchResults.map (searchResult) =>
          (img src: searchResult.get('thumburl'), style: { width: searchResult.get('thumbwidth'), height: searchResult.get('thumbheight')}, onClick: _.bind(@onImgClick, this, searchResult))
          )
        ]) 