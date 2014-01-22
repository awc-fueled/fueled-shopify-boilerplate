(function() {
  $(function() {
    $(document).on("click", ".js--toggle-thumbnail", function(e) {
      var alt, splitAlt, variant, _i, _len, _results;
      e.preventDefault();
      alt = $(this).attr("alt");
      splitAlt = alt.split(",");
      _results = [];
      for (_i = 0, _len = splitAlt.length; _i < _len; _i++) {
        variant = splitAlt[_i];
        variant = variant.trim();
        _results.push($('.single-option-selector').each(function(_i, _obj) {
          var _this = this;
          return $(_obj).find("option").each(function(_ii, _val) {
            if (variant === $(_val).val()) {
              return $(_this).val($(_val).val());
            }
          });
        }));
      }
      return _results;
    });
    return $(document).on("change", ".single-option-selector", function(e) {
      var variant;
      e.preventDefault();
      variant = [];
      $('.single-option-selector').each(function(_i, _obj) {
        if (_i === 0) {
          return variant.push($(_obj).val());
        } else {
          return variant.push(" " + $(_obj).val());
        }
      });
      return $(".js--toggle-thumbnail").each(function(_i, _val) {
        var alt;
        alt = $(_val).attr("alt").split(",");
        if (variant.toString() === alt.toString()) {
          return alert("match found v = " + variant + "; a = " + alt);
        }
      });
    });
  });

}).call(this);
