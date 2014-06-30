(function() {
  require(['models/test', 'jquery', 'react', 'utils/on_selection'], function(test, jquery, react, on_selection) {
    var style;
    style = document.createElement('link');
    style.rel = 'stylesheet';
    style.type = 'text/css';
    style.href = chrome.extension.getURL('styles/content.css');
    (document.head || document.documentElement).appendChild(style);
    return $(function() {
      return on_selection(function(obj) {
        return console.log(obj);
      });
    });
  });

}).call(this);
