define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img, span, footer} = React.DOM
  ImageDetailComponent = React.createClass
    model: ->
      # we might call title befire the component can initiate itself
      return @state.model if @state
      return @props.model
    getInitialState: ->
      model: @props.model
    title: ->
      @model().get('canonicaltitle')
    titleView: ->
      (a href: @model().get('title'), @title())
    artist: ->
      return @model().get('extmetadata').Artist.value if @model().get('extmetadata') and @model().get('extmetadata').Artist
      return "Unknown"
    previousImage: ->
      @model().collection.models[@model().collection.indexOf(@model()) - 1]
    nextImage: ->
      @model().collection.models[@model().collection.indexOf(@model()) + 1]
    goToImage: (image) -> (@setState model: image)
    goToPreviousImage: -> (@goToImage @previousImage())
    goToNextImage: -> (@goToImage @nextImage())
    render: ->
      (div className: 'erutpa-image-detail-component', [
        (div className: "erutpa-image-detail-component-image-container", [
          (img src: @model().get('url')),
          (span className: 'previous-button', onClick: @goToPreviousImage) if @previousImage()
          (span className: 'next-button', onClick: @goToNextImage) if @nextImage()
          ])
        
        (div className: 'erutpa-image-detail-component-meta', [
          (h5 {}, @model().get('canonicaltitle')),
          (p {}, @model().get('parsedcomment')),
          (footer {}, [
            (span {}, "Licensed under #{@model().get('extmetadata').LicenseShortName.value}, Author: "),
            (span dangerouslySetInnerHTML: {__html: @artist()})
            ])
          ])
        ])
