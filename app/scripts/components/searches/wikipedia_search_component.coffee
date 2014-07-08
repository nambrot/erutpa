define ['react', 'utils/backbone_mixin'], (React, BackboneMixin) ->
  {div, article, header, section, p, ul, li, h5, a} = React.DOM

  WikipediaSearchComponentRow = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div {}, [
        (h5 {}, @props.model.get("title"))
        (p {}, @props.model.get("extract"))
        (a href: "https:/www.google.com", "Google")
        ])
  WikipediaSearchComponent = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (div className: "erutpa-keyword-card-search-card erutpa-wikipedia", @props.model.searchResults.map (searchResult) ->
        (WikipediaSearchComponentRow model: searchResult)
        )