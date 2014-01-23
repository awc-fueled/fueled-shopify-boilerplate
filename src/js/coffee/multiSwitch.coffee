#multiSwitch.coffee
multiSwitch =
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
        # build product variant string
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
        $(".js--toggle-slide").each ( _i, _obj ) =>
            alt = $( _obj ).attr( "alt" ).split( "," )
            if ( variant.toString() is alt.toString() ) 
                alert "match found v = #{variant}; a = #{alt}"
                # activate slide in the flexslider
                $('.flexslider--product').flexslider( _i ) 

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




               
        
                
        