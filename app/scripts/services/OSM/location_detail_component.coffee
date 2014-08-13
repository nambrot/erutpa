define ['react', 'utils/backbone_mixin', 'underscore', 'leaflet'], (React, BackboneMixin, _, Leaflet) ->
  {div, article, header, section, p, ul, li, h5, a, img, span} = React.DOM

  LocationDetailComponent = React.createClass
    mixins: [BackboneMixin]
    title: ->
      "Map for #{@props.model.attributes.dbpediaData.data['http://dbpedia.org/property/name'][0].value}"
    titleView: ->
      (span {}, "Map for #{@props.model.attributes.dbpediaData.data['http://dbpedia.org/property/name'][0].value}")
    componentDidMount: ->
      map = L.map @refs.mapEl.getDOMNode()
        .setView([@props.model.lat(), @props.model.lng()], 13)
      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map)
    render: ->
      (div className: "erutpa-Location", ref: 'mapEl', style: { height: '600' } )