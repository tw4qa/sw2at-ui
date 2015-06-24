# sw2at-ui
## SWAT(Simple Way to Automate Tests) - UI
Gem helps in testing of Rails applications.
* track your test revisions
* easily confugure and reun tests in parallel
* share testing results with team members and customers

## How to install Rails app with sw2at-ui from scratch

Create app (skip this if you have app already)
```
gem install rails
rails new swat-ui-app
cd swat-ui-app
```
add RSpec gem to your Gemfile (skip this if you have rspec already)
```ruby
gem 'rspec', '~> 3.0'
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
```

install RSpec(skip this if you have rspec already)
```
bundle install
rails generate rspec:install
```

add sw2at-ui gem  to your Gemfile
```ruby
gem 'sw2at-ui', '0.0.6'
```
Install `sw2at-ui`
```
bundle install
rails g swat:ui:install
```
Go to [firebase.com](firebase.com) and create a free acount there to get your https path.

Insert it in `Rails.root/initializers/swat_ui.rb`. You can define your [parallelism settings](#) here.

Edit yout `Rails.root/config/routes.rb`
```ruby
Rails.application.routes.draw do

  unless Rails.env.production?
    require 'sw2at-ui'
    mount Swat::Engine => '/swat'
  end
  
end
```
Connect sw2at-ui to RSpec. Edit your `Rails.root/spec/rails_helper.rb`, add following lines
```ruby
require 'rspec/core/formatters/base_text_formatter'
config.formatter = RSpec::Core::Formatters::BaseTextFormatter # if you don't use any custom formatters.
Swat::UI.rspec_config = config
```
Add a test. For example 
```ruby
it 'should chec math' do
  expect(2+2).to eq(4)
end
```

Run rspec
```
rspec
```
or with a swat-ui runner 
```
SWAT_CURRENT_REVISION_NAME='Hello SWAT!' rake swat:ci:run
```

Now you can check your results at [http://localhost:3000/swat](http://localhost:3000/swat). 
(don't forget to start the app with `rails s`)
![alt tag](https://github.com/tw4qa/sw2at-ui/blob/master/docs/resources/swat-ui-example.png)
    
    
## Examples
You can check a configured example [here](https://github.com/tw4qa/swat-ui-example).

## Contributing to sw2at-ui
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2015 Vitaly Tarasenko. See LICENSE.txt for
further details.

