require ['jquery', 'react', 'utils/on_selection', 'components/main_component'], ($, react, on_selection, main_component) ->
  # inject css
  style = document.createElement('link')
  style.rel = 'stylesheet'
  style.type = 'text/css'
  style.href = chrome.extension.getURL('styles/content.css')
  (document.head||document.documentElement).appendChild(style)

  $ ->
    erutpaNode = document.createElement 'div'

    main = react.renderComponent (main_component {}), erutpaNode
    document.body.appendChild erutpaNode

    on_selection (obj, evt) ->
      main.addKeyword obj.modified_string, evt