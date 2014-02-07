$( window ).load ->
    $( '.flexslider' ).flexslider()

$ ->
    $( document ).on "click", ".js--toggle-menu", (e) ->
        $( ".menu--primary > ul" ).toggle()



