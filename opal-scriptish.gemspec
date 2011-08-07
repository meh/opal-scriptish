Gem::Specification.new {|s|
  s.name         = 'opal-scriptish'
  s.version      = '0.0.1'
  s.author       = 'meh.'
  s.email        = 'meh@paranoici.org'
  s.homepage     = 'http://github.com/distro/opal-scriptish'
  s.platform     = Gem::Platform::RUBY
  s.summary      = 'A library to write Scriptish/Greasemonkey scripts in Ruby.'
  s.files        = Dir.glob('lib/**/*.rb')
  s.require_path = 'lib'
  s.executables  = ['opal-scriptish']

  s.add_dependency('opal')
}
