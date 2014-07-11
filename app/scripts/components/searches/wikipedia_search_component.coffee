define ['react', 'utils/backbone_mixin', 'underscore'], (React, BackboneMixin, _) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM

  WikipediaDetailComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      if @props.model.get("text")
        (div className: 'erutpa-detail-component erutpa-wikipedia', dangerouslySetInnerHTML: {__html: @props.model.get("text")})
      else
        (div className: 'erutpa-detail-component erutpa-wikipedia', "LOading")
  WikipediaSearchComponentRow = React.createClass
    mixins: [BackboneMixin]
    render: ->
      image = null
      image = (img src: @props.model.get('thumbnail').source) if @props.model.get('thumbnail')
      (div className: 'erutpa-wikipedia-search-result-snippet', onClick: _.bind(@props.addSubview, this, _.bind(WikipediaDetailComponent, this, model: @props.model)), [
        (image)
        (h5 {}, @props.model.get("title"))
        (p {}, @props.model.get("extract"))
        ])
  WikipediaSearchComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-wikipedia", @props.model.searchResults.map (searchResult) =>
        (WikipediaSearchComponentRow model: searchResult, addSubview: @props.addSubview)
        )