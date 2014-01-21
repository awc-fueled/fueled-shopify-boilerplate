(function() {
  $(function() {
    $(document).on("click", ".js--toggle-search", function(e) {
      $(".search__form--pop").toggle();
      return e.preventDefault();
    });
    return $(document).on("click", ".js--toggle-search--close", function(e) {
      $(".search__form--pop").toggle();
      return e.preventDefault();
    });
  });

}).call(this);
