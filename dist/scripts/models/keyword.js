(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'models/search_results/search_result_collection'], function(Backbone, SearchResultCollection) {
    var Keyword, _ref;
    return Keyword = (function(_super) {
      __extends(Keyword, _super);

      function Keyword() {
        _ref = Keyword.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Keyword.prototype.initialize = function(options) {
        Keyword.__super__.initialize.call(this, options);
        return this.fetch();
      };

      Keyword.prototype.searchResults = new SearchResultCollection();

      Keyword.prototype.fetch = function() {};

      return Keyword;

    })(Backbone.Model);
  });

}).call(this);
