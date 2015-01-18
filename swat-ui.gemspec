Gem::Specification.new do |s|
  s.name        = 'swat-ui'
  s.version     = '0.0.0'
  s.date        = '2014-11-20'
  s.summary     = 'Swat UI'
  s.description = 'Tool for end-to-end tests'
  s.authors     = ['Vitaly Tarasenko']
  s.email       = 'vetal.tarasenko@gmail.com'
  s.files       = ['lib/swat_ui.rb']

  s.add_dependency('rails', '~> 4.1.1')
  s.add_dependency('swat-capybara', '~> 0.0.0')
  s.add_dependency('firebase', '~> 0.2.2')

  s.homepage    = 'http://tw.coming.soon'
  s.license     = 'MIT'
end