define ['q','jquery', 'underscore'], (Q, $, _) -> 
  Wikipedia =
    query: (q) ->
      deferred = Q.defer()

      $.getJSON "https://en.wikipedia.org/w/api.php?action=query&titles=#{escape(q)}&prop=info|extracts|pageimages&format=json&explaintext=true&exchars=300&inprop=url&pithumbsize=100&redirects", (evt) ->
        delete evt.query.pages["-1"]
        deferred.resolve _.values(evt.query.pages)

      deferred.promise

    parseById: (id) ->
      deferred = Q.defer()
      $.getJSON "https://en.wikipedia.org/w/api.php?action=parse&format=json&pageid=#{escape(id)}&prop=text&disableeditsection=", (evt) ->
        if evt.error
          deferred.reject evt.error
        else
          text = evt.parse.text["*"]
          text = text.replace /<a href="\/w/g, '<a href="//en.wikipedia.org/w'
          title = evt.parse.title
          link= "http://en.wikipedia.org/wiki/index.html?curid=#{id}"
          deferred.resolve text: text, id: id, fullurl: link, title: title

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

    parseImageResponse: (resp) ->
      _.chain(resp.query.pages).values().filter((a) -> a.imageinfo and a.imageinfo[0]).collect((a) -> a.imageinfo[0]).value()
    getImages: (title, limit=50)->
      deferred = Q.defer()
      $.getJSON "http://commons.wikimedia.org/w/api.php?action=query&prop=imageinfo&format=json&iiprop=comment%7Cparsedcomment%7Ccanonicaltitle%7Curl%7Cextmetadata&iilimit=1&iiurlheight=100&titles=#{escape title}&generator=images&gimlimit=#{limit}", (resp) =>
        unless resp.query
          #try via category
          $.getJSON "https://commons.wikimedia.org/w/api.php?action=query&generator=categorymembers&gcmtype=file&gcmtitle=Category:#{escape title}&prop=info%7Cimageinfo&gcmlimit=#{limit}&iiprop=url&iiurlheight=100&format=json&iiprop=comment%7Cparsedcomment%7Ccanonicaltitle%7Curl%7Cextmetadata", (resp) =>
            unless resp.query
              deferred.resolve []
            else
              deferred.resolve @parseImageResponse resp
        else
          deferred.resolve @parseImageResponse resp
      deferred.promise