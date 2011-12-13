require 'bundler/setup'
require 'opal'
require 'opal/builder_task'

Opal::BuilderTask.new do |t|
	# this is the default, but have it here for clarity
	t.files = Dir['lib/**/*.rb']

	t.config :default do
		t.out = 'opal-scriptish.js'

		t.stdlib = [:forwardable, :singleton]
	end
end

task :default => ['opal:default']
