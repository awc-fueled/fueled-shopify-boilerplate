(function() {
  $(window).load(function() {
    return $('.flexslider').flexslider();
  });

  $(function() {
    return $(document).on("click", ".js--toggle-menu", function(e) {
      return $(".menu--primary > ul").toggle();
    });
  });

}).call(this);
