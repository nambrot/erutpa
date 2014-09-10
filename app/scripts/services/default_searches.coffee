define ['services/wikipedia/wikipedia_search', 'services/dbpedia/dbpedia_search', 'services/video/video_search', 'services/news/news_search', 'services/freebase/freebase_search'], (WikipediaSearch, DbpediaSearch, VideoSearch, NewsSearch, FreebaseSearch) ->
  [VideoSearch, NewsSearch, FreebaseSearch]