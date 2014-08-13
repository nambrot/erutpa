define ['react', 'utils/backbone_mixin', 'underscore', 'leaflet', 'services/OSM/location_detail_component'], (React, BackboneMixin, _, Leaflet, LocationDetailComponent) ->
  {div, article, header, section, p, ul, li, h5, a, img} = React.DOM

  LocationSearchComponent = React.createClass
    mixins: [BackboneMixin]
    componentDidMount: ->
      map = L.map @refs.mapEl.getDOMNode(), zoomControl: false, dragging: false, touchZoom: false, scrollWheelZoom: false, doubleClickZoom: false, boxZoom: false
        .setView([@props.model.lat(), @props.model.lng()], @props.model.zoomLevel())

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map)
    onClick: ->
      @props.addSubview _.bind(LocationDetailComponent, this, model: @props.model)
      return false
    render: ->
      (div className: "erutpa-location", [
        (h5 className:'erutpa-keyword-card-search-card-title', "Map for #{@props.model.attributes.dbpediaData.data['http://dbpedia.org/property/name'][0].value}")
        (div className: "", ref: 'mapEl', style: { height: '150' }, onClick: @onClick )
        ])
      