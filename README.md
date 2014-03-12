# TrackableClick

TrackableClick provides submit and link view helpers in ROR that can be tracked via Google analytic event, Google analytic e-commerce transaction, and Facebook pixel.
It is implemented using unobtrusive Javascript and integrates via Railties.

## Installation

Add this line to your application's Gemfile:

    gem 'trackable-click'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trackable-click

Add trackable click to your javascript manifest:

    #= require trackable-click

Add GA snippet to your layout file (example in HAML):

    - should_perform_tracking do
      :javascript
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-4JJHHJL9-1', {'cookieDomain':'none'});
        ga('send', 'pageview');

Enable trackable click via rails config:

    Application.configure do
      config.tracking_clicks = true
    end

## Usage

    1. submit example GA e-commerce
        = trackable_submit 'Place Order', google_commerce: {id:'1', affiliation: 'test product', revenue: '10.00', shipping:'0.00', tax:'0.00'}
    2. submit example GA Event
        = trackable_submit 'Place Order', google_event: {action: 'click', label: 'User Placed Order'}, fp_pixel: {id: '6014085521316', value: '10.00', currency: 'USD'}
    3. submit example Facebook Pixel
        = trackable_submit 'Place Order', fp_pixel: {id: '6014085521316', value: '10.00', currency: 'USD'}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
