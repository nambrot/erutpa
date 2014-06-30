
require ['models/test', 'jquery', 'react', 'utils/on_selection'], (test, jquery, react, on_selection) ->
  # inject css
  style = document.createElement('link')
  style.rel = 'stylesheet'
  style.type = 'text/css'
  style.href = chrome.extension.getURL('styles/content.css')
  (document.head||document.documentElement).appendChild(style)

  $ ->
    on_selection (obj) ->
      console.log obj  