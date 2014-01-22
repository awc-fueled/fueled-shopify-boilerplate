(function() {
  $(window).load(function() {
    $('.flexslider').flexslider();
    return $('.flexslider--product').flexslider({
      animation: "slide",
      controlNav: "thumbnails",
      slideshow: false
    });
  });

}).call(this);
