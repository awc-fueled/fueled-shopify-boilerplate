#multiSwitch.coffee
multiSwitch =
    init: ->
        $( ".flex-control-thumbs > li > img" ).each ( _i, _obj) ->
                $( _obj ).addClass( "js--toggle-thumbnail" )
        # handles the case, where product is listed as unavailable on
        # page load when variants have not yet been selected
        $("#price-preview").text("Select a Product")

    activateClass: ( that, activeClass ) ->
        $( "." + activeClass ).removeClass( activeClass )
        $( that ).parent().addClass( activeClass )


    splitAltText: ( that ) ->
        # extract the displayed product variant from images alt text
        return ( $( that ).attr "alt" ).split( "," )

    updateSelect: ( splitAltText ) ->
        # find each selector and match value with alt text variant value
        for variant in splitAltText
            variant = variant.trim()
            $( '.single-option-selector' ).each ( _i, _obj ) ->
                $( _obj ).find( "option" ).each ( _ii, _val ) =>
                    # set selectors to product variant               
                    if variant is $( _val ).val() then $( @ ).val( $( _val ).val() )

    variantFromSelect: ->
        # gets the currently selected variant from each 
        # selector, and then builds the product variant string
        variant = []
        $( '.single-option-selector' ).each ( _i, _obj )->
                if _i == 0
                    variant.push $( _obj ).val()
                else
                    variant.push " " + $( _obj ).val()
        return variant

    filterThumbnails: ( alt, variant, _i ) ->
        # loop through variants associated with the flexslider slides and compare to
        # current product selection. If  variant of slide = current filter then reveal thumb.  
        if ( variant.indexOf(" ") > -1 )

            altInVariantCount = 0
            validVariants = []

            for a, indexAlt in alt
                for v in variant
                    if v != " " 
                        if v not in validVariants then validVariants.push( v )

                    if v?.trim() == a.trim() 
                        altInVariantCount += 1

                if ( indexAlt is ( alt.length - 1 ) ) and ( altInVariantCount is validVariants.length )
                    console.log "on"
                    # reveal thumbnail
                    $( $( ".flex-control-thumbs > li > img" )[ _i ] ).addClass( "js--toggle-thumbnail--visibility" )
                    #reset 
                    altInVariantCount = 0
                    validVariants = []
                else if ( indexAlt is ( alt.length - 1 ) )
                    console.log "off"
                    # hide thumbnail
                    $( $( ".flex-control-thumbs > li > img" )[ _i ] ).removeClass( "js--toggle-thumbnail--visibility" )
                    altInVariantCount = 0
                    validVariants = []

    
    revealThumbnail: ( _i) ->
        # reveal single thumbnail only
        $('.js--toggle-thumbnail--visibility').removeClass("js--toggle-thumbnail--visibility")
        $( $( ".flex-control-thumbs > li > img" )[ _i ] ).addClass("js--toggle-thumbnail--visibility")  

    findVariantFromSelect: ->
        variant = @.variantFromSelect()

        $(".flexslider--product li:not(.clone) .js--toggle-slide").each ( _i, _obj ) =>
            alt = @.splitAltText( _obj )
            @.filterThumbnails( alt, variant, _i )

            if ( variant.toString() is alt.toString() ) 
                $('.flexslider--product').flexslider( _i )
                @.revealThumbnail( _i )
                

    

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
        multiSwitch.updateSelect( multiSwitch.splitAltText( @ ) )
        multiSwitch.activateClass( @, "flex-active-slide" )
        multiSwitch.revealThumbnail( $(".flexslider--product").data("flexslider").currentSlide )
                   

    $(document).on "change", ".single-option-selector", ( e ) ->     
        e.preventDefault()
        multiSwitch.findVariantFromSelect()        

    $(document).on "click", ".js--toggle-thumbnail", ( e ) ->  
        src = $( @ ).attr( "src" )
        $( ".flexslider--product li:not(.clone) .js--toggle-slide" ).each ( _i, _obj ) =>
            if $( _obj ).attr( "src" ) == src
                multiSwitch.updateSelect( multiSwitch.splitAltText( _obj ))
                multiSwitch.activateClass( _obj, "flex-active" )
                multiSwitch.revealThumbnail( _i )






               
        
                
        