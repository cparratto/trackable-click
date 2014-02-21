$(document).ready(function() {
    $('body').delegate( ".trackable-click", "click", function() {
        if($(this).data('tc-fb-pixel-id') &&
           $(this).data('tc-fb-pixel-value') &&
           $(this).data('tc-fb-pixel-currency')) {
                window.fb_param = {}; // must be global by adding `window.`
                fb_param.pixel_id = $(this).data('tc-fb-pixel-id');
                fb_param.value = $(this).data('tc-fb-pixel-value');
                fb_param.currency = $(this).data('tc-fb-pixel-currency');

                (function(){
                    var fpw = document.createElement('script'); fpw.async = true; fpw.src = '//connect.facebook.net/en_US/fp.js';
                    var ref = document.getElementsByTagName('script')[0];
                    ref.parentNode.insertBefore(fpw, ref);
                })();
        }

        if($(this).data('tc-google-event-action') &&
           $(this).data('tc-google-event-label')){
            var action = $(this).data('tc-google-event-action');
            var label = $(this).data('tc-google-event-label');

            if($(this).data('tc-google-button-event-value')) {
                console.log("SHould have sen google.event " + label + " " + action);
                ga('send', 'event', 'button', action , label, $(this).data('tc-google-button-event-value'));
            } else {
                console.log("SHould have sen google.event " + label + " " + action);
                ga('send', 'event', 'button', action , label);
            }


        }
    });
});