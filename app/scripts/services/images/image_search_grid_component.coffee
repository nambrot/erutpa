define ['react', 'utils/backbone_mixin', 'underscore','services/images/image_detail_component',], (React, BackboneMixin, _, ImageDetailComponent) ->
  {div, article, header, section, p, ul, li, h5, a, img, span} = React.DOM
  ImageSearchGridComponent = React.createClass
    mixins: [BackboneMixin]
    title: ->
      "Images for #{@props.model.keyword()}"
    titleView: ->
      (span {}, @title())
    onImgClick: (model) ->
      @props.addSubview _.bind(ImageDetailComponent, this, model: model)
      return false
    render: ->
      (div className: 'erutpa-images-grid', @props.model.searchResults.map (searchResult) =>
        (div className: 'erutpa-images-grid-image', onClick: _.bind(@onImgClick, this, searchResult), style: {backgroundImage: "url(#{searchResult.get('thumburl')})"} )
        )