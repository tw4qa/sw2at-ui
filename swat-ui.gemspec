$:.push File.expand_path('../lib', __FILE__)
require 'swat/ui/version'

Gem::Specification.new do |s|
  s.name        = 'swat-ui'
  s.version     = Swat::UI::VERSION
  s.date        = '2014-11-20'
  s.summary     = 'Swat UI'
  s.description = 'Tool for end-to-end tests'
  s.authors     = ['Vitaly Tarasenko']
  s.email       = 'vetal.tarasenko@gmail.com'
  s.files       = ['lib/swat_ui.rb']


  s.add_development_dependency 'rspec'
  s.add_development_dependency 'combustion', '~> 0.3.1'

  s.test_files = Dir["spec/**/*"]

  s.add_dependency('swat-capybara', '~> 0.0.0')

  s.add_dependency('rails')

  s.add_dependency 'fire-model', '~> 0.0.9'
  s.add_dependency('slim-rails')
  s.add_dependency('sass-rails')
  s.add_dependency('coffee-rails')
  s.add_dependency('bootstrap-sass', '~> 3.0.3.0')

  s.homepage    = 'http://tw.coming.soon'
  s.license     = 'MIT'
end