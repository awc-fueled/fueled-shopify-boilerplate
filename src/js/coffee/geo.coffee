#Geo.Coffee
 
geo =
    init: ->
        $(document).on "click",".loc", (e) ->
            e.preventDefault()
            geo.updateFields("loading")
            geo.jQueryTesting()
            alert "loading"
            geo.getLoc()

        ### Check for location on dom ready ###
        if localStorage.cc? else geo.getLoc()

        
    getProperty: (obj, prop) ->
        if obj[prop]? then obj[prop] else obj
 
    updateFields: (location) ->
        $('#region-name').html @.getProperty(location, "region_name")
        $('#areacode').html @.getProperty(location, "areacode")
        $('#ip').html @.getProperty(location, "ip")  
        $('#zipcode').html @.getProperty(location, "zipcode")  
        $('#longitude').html @.getProperty(location, "longitude")  
        $('#latitude').html @.getProperty(location, "latitude") 
        $('#country-name').html @.getProperty(location, "country_name")  
        $('#country-code').html @.getProperty(location, "country_code")
        $('#city').html @.getProperty(location, "city") 
        $('#region-code').html @.getProperty(location, "region_code")

        ### localStorage declarations ###
        localStorage['cc'] = @.getProperty(location, "country_code")
        localStorage['lat'] = @.getProperty(location, "latitude")
        localStorage['long'] = @.getProperty(location, "longitude")
        console.log @.getProperty(location, "country_code")
 
    errorTesting: (location, textStatus, jqXHR) ->
        console.log "callback running"
        console.log textStatus
        console.log jqXHR
 
    jQueryTesting: ->
        console.log localStorage.cc
        console.log $.fn.jquery
 
    success: (location, textStatus, jqXHR) ->  
        @.errorTesting(location, textStatus, jqXHR)
        @.updateFields(location)
        $(".loc").css("background", "hsl(177, #{Math.random() * 100}%, #{Math.random() * 100}%)")
        if localStorage.cc is "US" then alert "You're From The US"
        if localStorage.cc is "UK" then alert "'ello Marc, You're From The UK"
 
    error:  (jqXHR, textStatus, errorThrown) ->
        alert "error"
        alert textStatus
 
    getLoc: -> 
        $.ajax
            dataType: "jsonp"
            url: 'http://freegeoip.net/json/?callback=?'
            success: (location, textStatus, jqXHR) => @.success(location, textStatus, jqXHR)
            error: (jqXHR, textStatus, errorThrown) => @.error(jqXHR, textStatus, errorThrown)
 
$ ->
    geo.jQueryTesting()
    geo.init()
    
geo.jQueryTesting()