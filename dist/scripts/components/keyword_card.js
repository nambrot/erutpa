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
            div({
              className: 'erutpa-keyword-card-result-item'
            }, [p({}, "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum doloribus corrupti laboriosam a provident obcaecati quia ab rerum hic cupiditate id vel accusamus impedit recusandae amet ratione ipsa eos animi.")]), div({}, [p({}, "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum doloribus corrupti laboriosam a provident obcaecati quia ab rerum hic cupiditate id vel accusamus impedit recusandae amet ratione ipsa eos animi.")])
          ])
        ]);
      }
    });
  });

}).call(this);
