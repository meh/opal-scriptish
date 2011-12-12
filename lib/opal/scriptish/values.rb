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

class Values
	include Singleton
	include Enumerable

	attr_accessor :default, :default_proc

	def initialize (&block)
		@default_proc = block if block
	end

	def has_key? (name)
		`GM_getValue(#{JSON.dump(name)}) !== undefined`
	end

	def [] (name)
		if has_key?(name)
			JSON.parse(`GM_getValue(#{JSON.dump(name)})`)
		else
			return default                       if default
			return default_proc.call(self, name) if default_proc
			return nil
		end
	end

	def []= (name, value)
		`GM_setValue(#{JSON.dump(name)}, #{JSON.dump(value)})`
	end

	def delete (name)
		`GM_deleteValue(#{JSON.dump(name)})`
	end

	def each (&block)
		Array(`GM_listValues()`).each {|name|
			block.call(name, self[name]);
		}
	end
end

end
