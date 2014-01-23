(function() {
  var multiSwitch;

  multiSwitch = {
    activateClass: function(that, activeClass) {
      $("." + activeClass).removeClass(activeClass);
      return $(that).parent().addClass(activeClass);
    },
    splitAltText: function(that) {
      var alt;
      alt = $(that).attr("alt");
      return alt.split(",");
    },
    updateSelect: function(that) {
      var splitAltText, variant, _i, _len, _results;
      splitAltText = this.splitAltText(that);
      _results = [];
      for (_i = 0, _len = splitAltText.length; _i < _len; _i++) {
        variant = splitAltText[_i];
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
    },
    variantFromSelect: function() {
      var variant;
      variant = [];
      $('.single-option-selector').each(function(_i, _obj) {
        if (_i === 0) {
          return variant.push($(_obj).val());
        } else {
          return variant.push(" " + $(_obj).val());
        }
      });
      return variant;
    },
    findVariantFromSelect: function() {
      var variant,
        _this = this;
      variant = this.variantFromSelect();
      return $(".js--toggle-slide").each(function(_i, _obj) {
        var alt;
        alt = $(_obj).attr("alt").split(",");
        if (variant.toString() === alt.toString()) {
          alert("match found v = " + variant + "; a = " + alt);
          return $('.flexslider--product').flexslider(_i);
        }
      });
    }
  };

  $(function() {
    $(document).on("click", ".js--toggle-slide", function(e) {
      e.preventDefault();
      multiSwitch.updateSelect(this);
      return multiSwitch.activateClass(this, "flex-active-slide");
    });
    $(document).on("change", ".single-option-selector", function(e) {
      e.preventDefault();
      return multiSwitch.findVariantFromSelect();
    });
    return $(document).on("click", ".js--toggle-thumbnail", function(e) {
      var src;
      src = $(this).attr("src");
      return $(".js--toggle-slide").each(function(i, obj) {
        if ($(this).attr("src") === src) {
          multiSwitch.updateSelect(this);
          return multiSwitch.activateClass(this, "flex-active");
        }
      });
    });
  });

}).call(this);
