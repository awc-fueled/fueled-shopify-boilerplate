(function() {
  var geo;

  geo = {
    init: function() {
      $(document).on("click", ".loc", function(e) {
        e.preventDefault();
        geo.updateFields("loading");
        geo.jQueryTesting();
        alert("loading");
        return geo.getLoc();
      });
      /* Check for location on dom ready*/

      if (localStorage.cc != null) {

      } else {
        return geo.getLoc();
      }
    },
    getProperty: function(obj, prop) {
      if (obj[prop] != null) {
        return obj[prop];
      } else {
        return obj;
      }
    },
    updateFields: function(location) {
      $('#region-name').html(this.getProperty(location, "region_name"));
      $('#areacode').html(this.getProperty(location, "areacode"));
      $('#ip').html(this.getProperty(location, "ip"));
      $('#zipcode').html(this.getProperty(location, "zipcode"));
      $('#longitude').html(this.getProperty(location, "longitude"));
      $('#latitude').html(this.getProperty(location, "latitude"));
      $('#country-name').html(this.getProperty(location, "country_name"));
      $('#country-code').html(this.getProperty(location, "country_code"));
      $('#city').html(this.getProperty(location, "city"));
      $('#region-code').html(this.getProperty(location, "region_code"));
      /* localStorage declarations*/

      localStorage['cc'] = this.getProperty(location, "country_code");
      localStorage['lat'] = this.getProperty(location, "latitude");
      localStorage['long'] = this.getProperty(location, "longitude");
      return console.log(this.getProperty(location, "country_code"));
    },
    errorTesting: function(location, textStatus, jqXHR) {
      console.log("callback running");
      console.log(textStatus);
      return console.log(jqXHR);
    },
    jQueryTesting: function() {
      console.log(localStorage.cc);
      return console.log($.fn.jquery);
    },
    success: function(location, textStatus, jqXHR) {
      this.errorTesting(location, textStatus, jqXHR);
      this.updateFields(location);
      $(".loc").css("background", "hsl(180, " + (Math.random() * 100) + "%, " + (Math.random() * 100) + "%)");
      if (localStorage.cc === "US") {
        alert("You're From The US");
      }
      if (localStorage.cc === "UK") {
        return alert("'ello Marc, You're From The UK");
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      alert("error");
      return alert(textStatus);
    },
    getLoc: function() {
      var _this = this;
      return $.ajax({
        dataType: "jsonp",
        url: 'http://freegeoip.net/json/?callback=?',
        success: function(location, textStatus, jqXHR) {
          return _this.success(location, textStatus, jqXHR);
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return _this.error(jqXHR, textStatus, errorThrown);
        }
      });
    }
  };

  $(function() {
    return geo.init();
  });

}).call(this);
