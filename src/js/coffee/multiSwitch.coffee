#multiSwitch.coffee
multiSwitch =
    init: ->
        $( ".flex-control-thumbs > li > img" ).each ( _i, _obj) ->
                $( _obj ).addClass( "js--toggle-thumbnail" )
        $("#price-preview").text("Select a Product")

    activateClass: ( that, activeClass ) ->
        $( "." + activeClass ).removeClass( activeClass )
        $( that ).parent().addClass( activeClass )

    splitAltText: ( that ) ->
        # extract variant from images alt text
        alt = $( that ).attr "alt"
        return alt.split( "," )

    updateSelect: ( that ) ->
        splitAltText = @.splitAltText( that )
        # find each selector and match value with alt text variant value
        for variant in splitAltText
            variant = variant.trim()
            $( '.single-option-selector' ).each ( _i, _obj ) ->
                $( _obj ).find( "option" ).each ( _ii, _val ) =>
                    # set selectors to product variant               
                    if variant is $( _val ).val() then $( @ ).val( $( _val ).val() )
    variantFromSelect: ->
        # gets the selected variant proprety from each 
        # selector, and then builds the product variant string
        variant = []
        $( '.single-option-selector' ).each ( _i, _obj )->
                if _i == 0
                    variant.push $( _obj ).val()
                else
                    variant.push " " + $( _obj ).val()
        return variant

    findVariantFromSelect: ->
        variant = @.variantFromSelect()
   
        # find matching variant
        $(".flexslider--product li:not(.clone) .js--toggle-slide").each ( _i, _obj ) =>
            # prep stings to compare
            alt = $( _obj ).attr( "alt" ).split( "," )
            #variant = variant.splice?(variant.indexOf(" ", 2))
            if (variant.indexOf(" ") > -1 )
                variantCurrentlySelected = off
                for a in alt
                    variantCheck = 0
                    variantCount = 0  
                    for v in variant
                        if v != " "
                            variantCount += 1
                        if a.trim() == v?.trim()
                            variantCheck += 1
                            
                            if variantCheck is variantCount    
                                variantCurrentlySelected = on
                                $( $( ".flex-control-thumbs > li > img" )[_i] ).addClass("js--toggle-thumbnail--visibility")
                    
                    if ( alt.indexOf(a) is (alt.length - 1 ) ) and variantCurrentlySelected is off
                        $( $( ".flex-control-thumbs > li > img" )[_i] ).removeClass("js--toggle-thumbnail--visibility")  

            if ( variant.toString() is alt.toString() ) 
                # activate slide in the flexslider
                $('.flexslider--product').flexslider( _i )
                $('.js--toggle-thumbnail--visibility').removeClass("js--toggle-thumbnail--visibility")
                $( $( ".flex-control-thumbs > li > img" )[ _i ] ).addClass("js--toggle-thumbnail--visibility")

    

$( window ).load ->
    $( '.flexslider--product' ).flexslider(
        animation: "slide",
        controlNav: "thumbnails",
        slideshow: false,
        start: ->
            multiSwitch.init()                
    )
    

$ ->
    $(document).on "click", ".js--toggle-slide", ( e )  ->     
        e.preventDefault()
        multiSwitch.updateSelect( @ )
        multiSwitch.activateClass( @, "flex-active-slide" )
                   

    $(document).on "change", ".single-option-selector", ( e ) ->     
        e.preventDefault()
        multiSwitch.findVariantFromSelect()        

    $(document).on "click", ".js--toggle-thumbnail", ( e ) ->  
        src = $(@).attr( "src" )
        $( ".js--toggle-slide" ).each ( i, obj ) ->
            if $(@).attr( "src" ) == src
                multiSwitch.updateSelect( @ )
                multiSwitch.activateClass( @, "flex-active")




               
        
                
        