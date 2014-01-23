(function() {
  $(window).load(function() {
    $('.flexslider').flexslider();
    return $('.flexslider--product').flexslider({
      animation: "slide",
      controlNav: "thumbnails",
      slideshow: false,
      start: function() {
        return $(".flex-control-thumbs > li > img").each(function(_i, _obj) {
          return $(_obj).addClass("js--toggle-thumbnail");
        });
      }
    });
  });

}).call(this);
