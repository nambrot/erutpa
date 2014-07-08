(function() {
  require(['models/test', 'jquery', 'react', 'utils/on_selection', 'components/main_component', 'pep'], function(test, $, react, on_selection, main_component) {
    var style;
    style = document.createElement('link');
    style.rel = 'stylesheet';
    style.type = 'text/css';
    style.href = chrome.extension.getURL('styles/content.css');
    (document.head || document.documentElement).appendChild(style);
    return $(function() {
      var erutpaNode, main;
      erutpaNode = document.createElement('div');
      main = react.renderComponent(main_component({}), erutpaNode);
      document.body.appendChild(erutpaNode);
      return on_selection(function(obj) {
        console.log(obj);
        return main.addKeyword(obj.modified_string);
      });
    });
  });

}).call(this);
