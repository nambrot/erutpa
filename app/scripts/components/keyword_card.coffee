define ['react', 'utils/backbone_mixin', 'underscore', 'components/search_list_component'], (React, BackboneMixin, _, SearchListComponent) ->
  {div, article, header, section, p, ul, li, h2, span, input} = React.DOM

  KeywordCard = React.createClass
    # model: Keyword
    mixins: [BackboneMixin]

    getInitialState: ->
      subviews: [(SearchListComponent model: @props.model, addSubview: @addSubview)]
      keyword: @props.model.get('keyword')
    onChange: (evt) ->
      @setState keyword: evt.target.value
    onKeyUp: (evt) ->
      #change keyword on enter
      if evt.keyCode is 13
        evt.target.blur()
        @props.model.resetKeyword @state.keyword
        @resetSubviews()

    # display links we can handle
    getHandlingSearchFromLink: (link) ->
      _.chain @props.model.searches.models
        .map (search) -> ( search.canHandleLink(link) )
        .find (val) -> (val)
        .value()

    #attach link handler
    componentDidMount: ->
      $(@getDOMNode()).on 'click.erutpa', 'a', (evt) =>
        if search = @getHandlingSearchFromLink(evt.target.href)
          search.getSearchResultFromLink evt.target.href
          .then (searchResult) =>
            @addSubview _.bind(searchResult.component, this, model: searchResult)
          .fail (error) ->
            console.log error
          false
        else
          true

    addSubview: (subview) ->
      # we have to wrap in a function to avoid it getting moounted earlier
      subview = subview()
      subviews = @state.subviews
      subviews.push subview
      @setState subviews: subviews
      return false
    popSubview: ->
      subviews = @state.subviews
      subviews.pop()
      @setState subviews: subviews
    resetSubviews: ->
      @setState subviews: [(SearchListComponent model: @props.model, addSubview: @addSubview)]

    render: ->
      (article className: 'erutpa-keyword-card', [
        (header className: 'erutpa-keyword-card-header', [
          (span className: (if @state.subviews.length > 1 then "show back" else "back"), onClick: @popSubview),
          (input className: "erutpa-keyword-card-keyword-input", ref: 'keywordInput', value: @state.keyword, onChange: @onChange, onKeyUp: @onKeyUp)
          ])
        (div className: 'erutpa-keyword-card-canvas', @state.subviews.map((subview, index) => 
            style = marginLeft: "-#{400 * (@state.subviews.length - 1)}px" if index is 0
            (div className: "erutpa-keyword-card-subview", style: style, subview)
          )),
        (div className: 'erutpa-keyword-card-bottom-bar', _.last(@state.subviews).titleView())
      ])