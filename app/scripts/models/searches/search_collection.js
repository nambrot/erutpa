(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['models/searches/search', 'models/searches/wikipedia_search', 'backbone'], function(Search, WikipediaSearch, Backbone) {
    var SearchCollection, _ref;
    return SearchCollection = (function(_super) {
      __extends(SearchCollection, _super);

      function SearchCollection() {
        _ref = SearchCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      SearchCollection.prototype.initialize = function(collection, options) {
        SearchCollection.__super__.initialize.call(this, options);
        if (options.keyword) {
          return this.keyword = options.keyword;
        }
      };

      SearchCollection.prototype.model = Search;

      SearchCollection.prototype.thatHaveResults = function() {
        return _.where(this.models, function(model) {
          return model.searchResults.length > 1;
        });
      };

      SearchCollection.prototype.searchDefault = function() {
        this.add(new WikipediaSearch({
          keyword: this.keyword
        }));
        return this.each(function(model) {
          return model.fetch();
        });
      };

      return SearchCollection;

    })(Backbone.Collection);
  });

}).call(this);
