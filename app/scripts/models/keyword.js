(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'models/searches/search_collection'], function(Backbone, SearchCollection) {
    var Keyword, _ref;
    return Keyword = (function(_super) {
      __extends(Keyword, _super);

      function Keyword() {
        _ref = Keyword.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Keyword.prototype.initialize = function(options) {
        var _this = this;
        Keyword.__super__.initialize.call(this, options);
        this.searches = new SearchCollection([], {
          keyword: this
        });
        this.searches.on('change reset add remove', function() {
          return _this.trigger('change');
        });
        return this.fetch();
      };

      Keyword.prototype.fetch = function() {
        return this.searches.searchDefault();
      };

      return Keyword;

    })(Backbone.Model);
  });

}).call(this);
