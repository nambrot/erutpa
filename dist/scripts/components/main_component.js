(function() {
  define(['react', 'components/keyword_card', 'models/keyword_collection', 'underscore', 'utils/backbone_mixin'], function(React, KeywordCard, KeywordCollection, _, BackboneMixin) {
    var MainComponent, div;
    div = React.DOM.div;
    return MainComponent = React.createClass({
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
