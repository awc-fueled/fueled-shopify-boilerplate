$ ->

    $(document).on "click", ".js--toggle-search", (e) ->         
        $(".search__form--pop").toggle()
        e.preventDefault() 
    
    $(document).on "click", ".js--toggle-search--close", (e) ->
        $(".search__form--pop").toggle()
        e.preventDefault()