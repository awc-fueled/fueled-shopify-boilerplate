(function() {
  var multiSwitch;

  multiSwitch = {
    init: function() {
      $(".flex-control-thumbs > li > img").each(function(_i, _obj) {
        return $(_obj).addClass("js--toggle-thumbnail");
      });
      return $("#price-preview").text("Select a Product");
    },
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
      return $(".flexslider--product li:not(.clone) .js--toggle-slide").each(function(_i, _obj) {
        var a, alt, v, variantCheck, variantCount, variantCurrentlySelected, _j, _k, _len, _len1;
        alt = $(_obj).attr("alt").split(",");
        if (variant.indexOf(" ") > -1) {
          variantCurrentlySelected = false;
          for (_j = 0, _len = alt.length; _j < _len; _j++) {
            a = alt[_j];
            variantCheck = 0;
            variantCount = 0;
            for (_k = 0, _len1 = variant.length; _k < _len1; _k++) {
              v = variant[_k];
              if (v !== " ") {
                variantCount += 1;
              }
              if (a.trim() === (v != null ? v.trim() : void 0)) {
                variantCheck += 1;
                if (variantCheck === variantCount) {
                  variantCurrentlySelected = true;
                  $($(".flex-control-thumbs > li > img")[_i]).addClass("js--toggle-thumbnail--visibility");
                }
              }
            }
            if ((alt.indexOf(a) === (alt.length - 1)) && variantCurrentlySelected === false) {
              $($(".flex-control-thumbs > li > img")[_i]).removeClass("js--toggle-thumbnail--visibility");
            }
          }
        }
        if (variant.toString() === alt.toString()) {
          $('.flexslider--product').flexslider(_i);
          $('.js--toggle-thumbnail--visibility').removeClass("js--toggle-thumbnail--visibility");
          return $($(".flex-control-thumbs > li > img")[_i]).addClass("js--toggle-thumbnail--visibility");
        }
      });
    }
  };

  $(window).load(function() {
    return $('.flexslider--product').flexslider({
      animation: "slide",
      controlNav: "thumbnails",
      slideshow: false,
      start: function() {
        return multiSwitch.init();
      }
    });
  });

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
