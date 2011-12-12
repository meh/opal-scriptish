#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

module Scriptish

class Resources
	include Singleton

	class Resource
		attr_reader :name

		def initialize (name)
			@name = name
		end

		def url
			`GM_getResourceURL(#@name)`
		end

		def to_s
			`GM_getResourceText(#@name)`
		end
	end

	def [] (name)
		Resource.new(name)
	end
end

end
