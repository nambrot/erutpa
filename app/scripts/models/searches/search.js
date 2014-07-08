(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'models/searches/search_result_collection', 'components/searches/wikipedia_search_component'], function(Backbone, SearchResultCollection, WikipediaSearchComponent) {
    var Search, _ref;
    return Search = (function(_super) {
      __extends(Search, _super);

      function Search() {
        _ref = Search.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Search.prototype.component = WikipediaSearchComponent;

      Search.prototype.fetchingStatus = "notYet";

      Search.prototype.initialize = function(options) {
        var _this = this;
        Search.__super__.initialize.call(this, options);
        this.searchResults = new SearchResultCollection([], {
          search: this
        });
        return this.searchResults.on('change reset add remove', function() {
          return _this.trigger('change');
        });
      };

      Search.prototype.fetch = function() {
        if (this.fetchingStatus === "fetched") {
          return;
        }
        return this.fetchingStatus = "fetched";
      };

      return Search;

    })(Backbone.Model);
  });

}).call(this);
