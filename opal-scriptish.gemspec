Gem::Specification.new {|s|
	s.name         = 'opal-scriptish'
	s.version      = '0.0.1'
	s.author       = 'meh.'
	s.email        = 'meh@paranoici.org'
	s.homepage     = 'http://github.com/meh/opal-scriptish'
	s.platform     = Gem::Platform::RUBY
	s.summary      = 'Opal support for GreaseMonkey and Scriptish.'

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']

	s.add_dependency 'opal-singleton'

	s.add_dependency 'opal-browser'
	s.add_dependency 'opal-json'
}
