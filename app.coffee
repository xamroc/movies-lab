"use strict"

$ ->
  $("input").focus()
  $("form").on "submit", (event) ->
    event.preventDefault()

    searchTerm  = $("input").val()

    movieData = $.ajax
      url: "http://www.omdbapi.com"
      method: "get"
      data: { s: searchTerm }
      dataType: "json"

    movieData.done (data) ->
      $("input").val("")
      $(".result").html("")

      for movie in data["Search"]
        li = $ "<li data-tuktuk='totals' data-imdbid='" + movie.imdbID + "'>" + movie.Title + "</li>"
        $(".result").append(li)

    $(".result").delegate "li", "click", (event) ->
      movieId = @.dataset.imdbid
      movieInfo = $.ajax
        url: "http://www.omdbapi.com"
        method: "get"
        data: { i: movieId }
        dataType: "json"

      movieInfo.done (data) ->
        imgSrc = data["Poster"]
        if imgSrc == "N/A"
          imgSrc = "http://www.mnit.ac.in/new/PortalProfile/images/faculty/noimage.jpg"
        $("img").attr("src", imgSrc)