$( window ).load ->
    $( '.flexslider' ).flexslider()

$ ->
    $( document ).on "click", ".js--toggle-menu", (e) ->
        $(".icon--menu").toggleClass("js--toggle-menu--rotate")
        $( ".menu--primary > ul" ).toggle()



