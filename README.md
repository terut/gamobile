gamobile
========
gamobile is Google Analytics for japanese mobile with rails 3.
This gem rewrite ga.php to rails with jpmobile.
So, require rails 3 and jpmobile.

Install
-------
Add gamobile to the `:development` groups in the Gemfile.

``` ruby
group :development do
  gem "gamobile", :git => "git://github.com/terut/gamobile.git"
end
```

Create controller and helper for google analytics.

``` bash
$ rails g gamobile:install [class_name] [tracking_code]
$ rails g gamobile:install mobile::analytics XX-77777777-77
    create  app/controllers/mobile/analytics_controller.rb
    create  app/helpers/mobile/analytics_helper.rb
```

Configure
---------

Add gamobile routing in the routes.rb.

``` ruby
namespace 'mobile' do
  match 'ga' => 'analytics#ga'
end
```

Edit gamobile helper and Confirm your tracking code in options.

``` ruby
# app/helpers/mobile/analytics_helper.rb

def ga_url

# TODO Rewrite url adapted to your routes.rb
# Example:
#   return mobile_ga_path(options)
  return "#" 
end
```

Add img tag in your views.

``` ruby
# app/views/mobile/foo.html.erb

<img src="<%= ga_url %>" width="1" height="1" />
```
