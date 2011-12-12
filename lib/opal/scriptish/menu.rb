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

class Menu
	include Singleton

	class Key
		def self.[] (*args)
			new(*args)
		end

		attr_accessor :key, :modifier, :access

		def initialize (key, modifier = nil, access = nil)
			@key      = key
			@modifier = modifier
			@access   = access
		end
	end

	class Command
		attr_reader :id, :caoption, :key, :block

		def initialize (id, caption, key = nil, &block)
			@id      = id
			@caption = caption
			@key     = key
			@block   = block
		end
	end

	def register (caption, key = nil, &block)
		raise ArgumentError, 'no block passed' unless block

		id = if key
			`GM_registerMenuCommand(caption, #{block.to_native}, #{key.key}, #{key.modifier}, #{key.access})`
		else
			`GM_registerMenuCommand(caption, #{block.to_native})`
		end

		Command.new(id, caption, key, &block)
	end

	def unregister (command)
		`GM_unregisterMenuCommand(#{Opal.string?(command) ? command : command.id})`
	end

	def enable (command)
		`GM_enableMenuCommand(#{Opal.string?(command) ? command : command.id})`
	end

	def disable (command)
		`GM_disableMenuCommand(#{Opal.string?(command) ? command : command.id})`
	end
end

end
