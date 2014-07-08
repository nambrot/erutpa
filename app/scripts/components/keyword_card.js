(function() {
  define(['react', 'utils/backbone_mixin'], function(React, BackboneMixin) {
    var KeywordCard, article, div, header, li, p, section, ul, _ref;
    _ref = React.DOM, div = _ref.div, article = _ref.article, header = _ref.header, section = _ref.section, p = _ref.p, ul = _ref.ul, li = _ref.li;
    return KeywordCard = React.createClass({
      mixins: [BackboneMixin],
      render: function() {
        return article({
          className: 'erutpa-keyword-card'
        }, [
          header({}, this.props.model.get('keyword')), div({
            className: 'erutpa-keyword-card-canvas'
          }, [
            _.map(this.props.model.searches.thatHaveResults(), function(search) {
              return div({
                className: 'erutpa-keyword-card-result-item'
              }, [
                _.map(search.searchResults.models, function(searchResult) {
                  return p({}, JSON.stringify(searchResult.attributes));
                })
              ]);
            })
          ])
        ]);
      }
    });
  });

}).call(this);
