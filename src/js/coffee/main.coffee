#init flexslider
$(window).load ->
    $('.flexslider').flexslider()
    $('.flexslider--product').flexslider(
        animation: "slide",
        controlNav: "thumbnails",
        slideshow: false,
    )
    