(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['models/searches/search_result', 'backbone'], function(SearchResult, Backbone) {
    var SearchResultCollection, _ref;
    return SearchResultCollection = (function(_super) {
      __extends(SearchResultCollection, _super);

      function SearchResultCollection() {
        _ref = SearchResultCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      SearchResultCollection.prototype.initialize = function(options) {
        SearchResultCollection.__super__.initialize.call(this, options);
        if (options.search) {
          return this.search = options.search;
        }
      };

      SearchResultCollection.prototype.model = SearchResult;

      return SearchResultCollection;

    })(Backbone.Collection);
  });

}).call(this);
