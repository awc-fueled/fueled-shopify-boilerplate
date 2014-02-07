(function() {
  $(window).load(function() {
    return $('.flexslider').flexslider();
  });

  $(function() {
    return $(document).on("click", ".js--toggle-menu", function(e) {
      $(".icon--menu").toggleClass("js--toggle-menu--rotate");
      return $(".menu--primary > ul").toggle();
    });
  });

}).call(this);
