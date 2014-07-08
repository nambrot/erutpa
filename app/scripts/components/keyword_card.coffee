define ['react', 'utils/backbone_mixin'], (React, BackboneMixin) ->
  {div, article, header, section, p, ul, li} = React.DOM
  KeywordCard = React.createClass
    mixins: [BackboneMixin]
    render: ->
      (article className: 'erutpa-keyword-card', [
        (header {}, @props.model.get('keyword')),
        (div className: 'erutpa-keyword-card-canvas', [
          _.map(@props.model.searches.thatHaveResults(), (search) -> 
            (div className: 'erutpa-keyword-card-result-item', [
              _.map(search.searchResults.models, (searchResult) ->
                (p {}, JSON.stringify(searchResult.attributes))
                )
              ])
            )
          # (div className: 'erutpa-keyword-card-result-item', [
          #   (p {}, "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum doloribus corrupti laboriosam a provident obcaecati quia ab rerum hic cupiditate id vel accusamus impedit recusandae amet ratione ipsa eos animi.")
          #   ]),
          # (div {}, [
          #   (p {}, "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum doloribus corrupti laboriosam a provident obcaecati quia ab rerum hic cupiditate id vel accusamus impedit recusandae amet ratione ipsa eos animi.")
          #   ])
          ])
        
        ])