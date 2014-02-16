$(document).ready(function() {
    $('body').delegate( ".trackable-click", "click", function() {
        window.fb_param = {}; // must be global by adding `window.`
        fb_param.pixel_id = $(this).data('tc-fb-pixel-id');
        fb_param.value = $(this).data('tc-fb-pixel-value');
        fb_param.currency = $(this).data('tc-fb-pixel-currency');
        (function(){
            var fpw = document.createElement('script'); fpw.async = true; fpw.src = '//connect.facebook.net/en_US/fp.js';
            var ref = document.getElementsByTagName('script')[0];
            ref.parentNode.insertBefore(fpw, ref);
        })();
    });
});