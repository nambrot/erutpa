define ['q','jquery', 'underscore'], (Q, $, _) -> 
  Wikipedia =
    query: (q) ->
      deferred = Q.defer()

      $.getJSON "https://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        delete evt.query.pages["-1"]
        deferred.resolve _.values(evt.query.pages)

      deferred.promise

    parse: (link) ->
      deferred = Q.defer()
      id = link.match(/\/\/en.wikipedia.org\/wiki\/(.*)/)[1]
      $.getJSON "https://en.wikipedia.org/w/api.php?action=parse&format=json&page=#{escape(id)}&redirects=&prop=text&disableeditsection=", (evt) ->
        if evt.error
          deferred.reject evt.error
        else
          text = evt.parse.text["*"]
          text = text.replace /<a href="\/w/g, '<a href="//en.wikipedia.org/w'
          title = id.replace /_/g, " "

          deferred.resolve text: text, id: id, fullurl: link, title: title

      deferred.promise

    getImages: (title)->
      deferred = Q.defer()
      $.getJSON "http://commons.wikimedia.org/w/api.php?action=query&prop=imageinfo&format=json&iiprop=comment%7Cparsedcomment%7Ccanonicaltitle%7Curl%7Cextmetadata&iilimit=10&iiurlheight=100&titles=#{escape title}&generator=images&gimlimit=10", (resp) ->
        unless resp.query
          deferred.resolve []
          return
        deferred.resolve _.chain(resp.query.pages).values().collect((a) -> a.imageinfo[0]).value()
      deferred.promise