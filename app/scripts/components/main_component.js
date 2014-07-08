(function() {
  define(['react', 'components/keyword_card', 'models/keyword_collection', 'underscore', 'utils/backbone_mixin', 'jquery', 'pep'], function(React, KeywordCard, KeywordCollection, _, BackboneMixin, $, pep) {
    var MainComponent, div;
    div = React.DOM.div;
    return MainComponent = React.createClass({
      componentDidMount: function() {
        return $(this.getDOMNode()).pep({
          elementsWithInteraction: '.erutpa-keyword-card-canvas',
          useCSSTranslation: false
        });
      },
      mixins: [BackboneMixin],
      getDefaultProps: function() {
        return {
          collection: new KeywordCollection([])
        };
      },
      getInitialState: function() {
        return {
          x: this.props.x || 0,
          y: this.props.y || 0
        };
      },
      addKeyword: function(keyword) {
        return this.props.collection.add({
          keyword: keyword
        });
      },
      render: function() {
        return div({
          className: (this.props.collection.length > 0 ? "show" : ""),
          draggable: true,
          id: "erutpa-main-component"
        }, _.map(this.props.collection.models, function(keyword) {
          return KeywordCard({
            model: keyword
          });
        }));
      }
    });
  });

}).call(this);
