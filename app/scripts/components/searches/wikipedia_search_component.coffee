define ['react', 'utils/backbone_mixin'], (React, BackboneMixin) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM

  WikipediaSearchComponentRow = React.createClass
    mixins: [BackboneMixin]
    render: ->
      image = null
      image = (img src: @props.model.get('thumbnail').source) if @props.model.get('thumbnail')
      (div className: 'erutpa-wikipedia-search-result-snippet', [
        (image)
        (h5 {}, @props.model.get("title"))
        (p {}, @props.model.get("extract"))
        ])
  WikipediaSearchComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-wikipedia", @props.model.searchResults.map (searchResult) ->
        (WikipediaSearchComponentRow model: searchResult)
        )