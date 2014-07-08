(function() {
  define(['react', 'utils/backbone_mixin'], function(React, BackboneMixin) {
    var WikipediaSearchComponent, WikipediaSearchComponentRow, article, div, h5, header, li, p, section, ul, _ref;
    _ref = React.DOM, div = _ref.div, article = _ref.article, header = _ref.header, section = _ref.section, p = _ref.p, ul = _ref.ul, li = _ref.li, h5 = _ref.h5;
    WikipediaSearchComponentRow = React.createClass({
      mixins: [BackboneMixin],
      render: function() {
        return div({}, [h5({}, this.props.model.get("title")), p({}, this.props.model.get("extract"))]);
      }
    });
    return WikipediaSearchComponent = React.createClass({
      mixins: [BackboneMixin],
      render: function() {
        return div({
          className: "erutpa-keyword-card-search-card erutpa-wikipedia"
        }, this.props.model.searchResults.map(function(searchResult) {
          return WikipediaSearchComponentRow({
            model: searchResult
          });
        }));
      }
    });
  });

}).call(this);
