(function() {
  var multiSwitch,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

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
      return ($(that).attr("alt")).split(",");
    },
    updateSelect: function(splitAltText) {
      var variant, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = splitAltText.length; _i < _len; _i++) {
        variant = splitAltText[_i];
        variant = variant.trim();
        _results.push($('.single-option-selector').each(function(_i, _selector) {
          var _this = this;
          return $(_selector).find("option").each(function(_ii, _option) {
            if (variant === $(_option).val()) {
              return $(_selector).val($(_option).val());
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
    filterThumbnails: function(alt, variant, _i) {
      var a, altInVariantCount, indexAlt, v, validVariants, _j, _k, _len, _len1, _results;
      if (variant.indexOf(" ") > -1) {
        altInVariantCount = 0;
        validVariants = [];
        console.log(variant);
        _results = [];
        for (indexAlt = _j = 0, _len = alt.length; _j < _len; indexAlt = ++_j) {
          a = alt[indexAlt];
          for (_k = 0, _len1 = variant.length; _k < _len1; _k++) {
            v = variant[_k];
            console.log("v: " + v + " ve: " + (v !== (" " || "")));
            if ((v !== " ") && (v !== "")) {
              if (__indexOf.call(validVariants, v) < 0) {
                validVariants.push(v);
              }
              if (v.trim() === a.trim()) {
                altInVariantCount += 1;
              }
            }
          }
          console.log("vv#: " + validVariants.length + " aiv: " + altInVariantCount + " vv: " + validVariants);
          if ((indexAlt === (alt.length - 1)) && (altInVariantCount === validVariants.length)) {
            $($(".flex-control-thumbs > li > img")[_i]).addClass("js--toggle-thumbnail--visibility");
            altInVariantCount = 0;
            _results.push(validVariants = []);
          } else if (indexAlt === (alt.length - 1)) {
            $($(".flex-control-thumbs > li > img")[_i]).removeClass("js--toggle-thumbnail--visibility");
            altInVariantCount = 0;
            _results.push(validVariants = []);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    },
    revealThumbnail: function(_i) {
      $('.js--toggle-thumbnail--visibility').removeClass("js--toggle-thumbnail--visibility");
      return $($(".flex-control-thumbs > li > img")[_i]).addClass("js--toggle-thumbnail--visibility");
    },
    findVariantFromSelect: function() {
      var variant,
        _this = this;
      variant = this.variantFromSelect();
      return $(".flexslider--product li:not(.clone) .js--toggle-slide").each(function(_i, _obj) {
        var alt;
        alt = _this.splitAltText(_obj);
        _this.filterThumbnails(alt, variant, _i);
        if (variant.toString() === alt.toString()) {
          $('.flexslider--product').flexslider(_i);
          return _this.revealThumbnail(_i);
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
      multiSwitch.updateSelect(multiSwitch.splitAltText(this));
      multiSwitch.activateClass(this, "flex-active-slide");
      return multiSwitch.revealThumbnail($(".flexslider--product").data("flexslider").currentSlide);
    });
    $(document).on("change", ".single-option-selector", function(e) {
      e.preventDefault();
      return multiSwitch.findVariantFromSelect();
    });
    return $(document).on("click", ".js--toggle-thumbnail", function(e) {
      var src,
        _this = this;
      src = $(this).attr("src");
      return $(".flexslider--product li:not(.clone) .js--toggle-slide").each(function(_i, _obj) {
        if ($(_obj).attr("src") === src) {
          multiSwitch.updateSelect(multiSwitch.splitAltText(_obj));
          multiSwitch.activateClass(_obj, "flex-active");
          return multiSwitch.revealThumbnail(_i);
        }
      });
    });
  });

}).call(this);
