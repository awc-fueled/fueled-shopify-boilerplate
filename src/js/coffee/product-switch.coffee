#product-switch.coffee
$ ->
    # productId and productOptions are defined within the template itself out of necessity
    $(document).on "click", ".js--toggle-thumbnail", (e) ->
        e.preventDefault()
        # cloudzoom image
        

        # extract variant from images alt text
        alt = $(@).attr "alt"
        splitAlt = alt.split(",")


        # find each selector and match value with alt text variant value
        for variant in splitAlt
            variant = variant.trim()
            $('.single-option-selector').each (_i, _obj) ->
                $(_obj).find("option").each (_ii, _val) =>               
                    if variant is $(_val).val() then $(@).val($(_val).val())
                   

    $(document).on "change", ".single-option-selector", (e) ->
        e.preventDefault()

        # build product variant string
        variant = []
        $('.single-option-selector').each (_i, _obj)->
                if _i == 0
                    variant.push $(_obj).val()
                else
                    variant.push " " + $(_obj).val()

        # find matching variant
        $(".js--toggle-thumbnail").each (_i, _val) ->
            alt = $(_val).attr("alt").split(",")
            if (variant.toString() is alt.toString()) 
                alert "match found v = #{variant}; a = #{alt}"
               
        
                
        