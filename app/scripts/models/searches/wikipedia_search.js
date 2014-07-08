(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'models/searches/search'], function(Backbone, $, Search) {
    var Wikipedia, WikipediaSearch, _ref;
    Wikipedia = {
      query: function(q, callback) {
        return $.getJSON("https://en.wikipedia.org/w/api.php?action=query&titles=" + (escape(q)) + "&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", function(evt) {
          delete evt.query.pages["-1"];
          return callback(_.values(evt.query.pages));
        });
      }
    };
    return WikipediaSearch = (function(_super) {
      __extends(WikipediaSearch, _super);

      function WikipediaSearch() {
        _ref = WikipediaSearch.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      WikipediaSearch.prototype.fetch = function() {
        var _this = this;
        WikipediaSearch.__super__.fetch.call(this);
        return Wikipedia.query(this.get('keyword').get('keyword'), function(results) {
          return _this.searchResults.add(results);
        });
      };

      return WikipediaSearch;

    })(Search);
  });

}).call(this);
