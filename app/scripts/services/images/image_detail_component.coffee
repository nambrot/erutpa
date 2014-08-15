define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img, span, footer} = React.DOM
  ImageDetailComponent = React.createClass
    title: ->
      @props.model.get('canonicaltitle')
    titleView: ->
      (a href: @props.model.get('title'), @title())
    artist: ->
      return @props.model.get('extmetadata').Artist.value if @props.model.get('extmetadata') and @props.model.get('extmetadata').Artist
      return "Unknown"
    render: ->
      console.log @props.model
      (div className: 'erutpa-image-detail-component', [
        (img src: @props.model.get('url')),
        (div className: 'erutpa-image-detail-component-meta', [
          (h5 {}, @props.model.get('canonicaltitle')),
          (p {}, @props.model.get('parsedcomment')),
          (footer {}, [
            (span {}, "Licensed under #{@props.model.get('extmetadata').LicenseShortName.value}, Author: "),
            (span dangerouslySetInnerHTML: {__html: @artist()})
            ])
          ])
        ])
