$(document).ready(function() {
    function trackableClickOnlyIf(element, prefix) {
      var trackable = ($(element).data(prefix + '-only-if') &&
          eval($(element).data(prefix + '-only-if'))) ||
          !$(element).data(prefix + '-only-if');
      return trackable;
    }

    function trackableClickEvalAttr(element, dataAttr) {
        var attr = '';

        try {
            attr = eval($(element).data(dataAttr));
        } catch (e) {
            attr = $(element).data(dataAttr);
        }

        return attr;
    }

    $('body').delegate( ".trackable-click", "click", function() {
        if($(this).data('tc-fb-pixel-id') &&
           $(this).data('tc-fb-pixel-value') &&
           $(this).data('tc-fb-pixel-currency')) {

            if(trackableClickOnlyIf(this, 'tc-fb-pixel')) {
                window.fb_param = {}; // must be global by adding `window.`
                fb_param.pixel_id = $(this).data('tc-fb-pixel-id');
                fb_param.value = trackableClickEvalAttr(this, 'tc-fb-pixel-value');
                fb_param.currency = trackableClickEvalAttr(this,'tc-fb-pixel-currency');

                (function(){
                    var fpw = document.createElement('script'); fpw.async = true; fpw.src = '//connect.facebook.net/en_US/fp.js';
                    var ref = document.getElementsByTagName('script')[0];
                    ref.parentNode.insertBefore(fpw, ref);
                })();
            }
        }

        if($(this).data('tc-google-event-action') &&
           $(this).data('tc-google-event-label')){
            var action = trackableClickEvalAttr(this,'tc-google-event-action');
            var label = trackableClickEvalAttr(this,'tc-google-event-label');

            if(trackableClickOnlyIf(this, 'tc-google-event')) {
                if($(this).data('tc-google-button-event-value')) {
                    ga('send', 'event', 'button', action , label, $(this).data('tc-google-button-event-value'));
                } else {
                    ga('send', 'event', 'button', action , label);
                }
            }
        }

        if($(this).data('tc-google-commerce-id') &&
           $(this).data('tc-google-commerce-affiliation') &&
           $(this).data('tc-google-commerce-revenue') &&
           $(this).data('tc-google-commerce-shipping') &&
           $(this).data('tc-google-commerce-tax')){

            var id = trackableClickEvalAttr(this,'tc-google-commerce-id');
            var affiliation = trackableClickEvalAttr(this,'tc-google-commerce-affiliation');
            var revenue = trackableClickEvalAttr(this,'tc-google-commerce-revenue');
            var shipping = trackableClickEvalAttr(this,'tc-google-commerce-shipping');
            var tax = trackableClickEvalAttr(this,'tc-google-commerce-tax');

            if(trackableClickOnlyIf(this, 'tc-google-commerce')) {
                ga('ecommerce:addTransaction', {
                    'id': id,
                    'affiliation': affiliation,
                    'revenue': revenue,
                    'shipping': shipping,
                    'tax': tax
                });
                ga('ecommerce:send');
            }
        }
    });
});