#init flexslider
$(window).load ->
    $('.flexslider').flexslider()
    $('.flexslider--product').flexslider(
        animation: "slide",
        controlNav: "thumbnails",
        slideshow: false,
        start: ->
            $( ".flex-control-thumbs > li > img" ).each ( _i, _obj) ->
                $( _obj ).addClass( "js--toggle-thumbnail" )
                
    )
    