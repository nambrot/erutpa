(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['models/keyword', 'backbone'], function(Keyword, Backbone) {
    var KeywordCollection, _ref;
    return KeywordCollection = (function(_super) {
      __extends(KeywordCollection, _super);

      function KeywordCollection() {
        _ref = KeywordCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      KeywordCollection.prototype.model = Keyword;

      return KeywordCollection;

    })(Backbone.Collection);
  });

}).call(this);
