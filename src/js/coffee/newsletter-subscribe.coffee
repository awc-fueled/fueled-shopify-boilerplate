# IsEmail (email) ->
#   regex = "/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/"
#   regex.test(email)

# $ ->
#   ### We might want to bypass the traditional mailchimp redirect. We'll have to redo their mailchimp form (super easy) ###
#   # $(document).on 'click', "#mc-embedded-subscribe", (e) ->
#   #   e.preventDefault()
#   #   if IsEmail($('#contact_email').val()) is on then $('#news_success').fadeIn(2000).fadeOut(5000)
#   #   else $('#news_failure').fadeIn(2000).fadeOut(5000)
       
 