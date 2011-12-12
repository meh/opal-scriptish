#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'opal/scriptish/values'
require 'opal/scriptish/console'
require 'opal/scriptish/request'
require 'opal/scriptish/resources'
require 'opal/scriptish/menu'

module Scriptish
	def get (name)
		Values::instance[name]
	end

	def set (name, value)
		Values::instance[name] = value
	end

	 def delete (name)
		Values::instance.delete(name)
	end

	def console
		Console::instance
	end

	def updatable?
		`GM_updatingEnabled()`
	end

	def window
		`unsafeWindow`
	end

	def metadata
		Hash(`GM_getMetadata()`)
	end

	def request (url, &block)
		Request.new(url, &block).start
	end

	def parse (text)
		Document(`GM_safeHTMLParser(#{text.to_s})`)
	end

	def resource (name)
		Resources::instance[name]
	end

	def log (text)
		`GM_log(#{text})`
	end

	def notify (message, title = undefined, icon = undefined, &block)
		`GM_notification(message, title, icon, #{block.to_native})`
	end

	def open_in_tab (url, background = undefined, reuse = undefined)
		`GM_openInTab(url, background, reuse)`
	end

	def menu
		Menu::instance
	end

	def clipboard (text, type = 'text')
		`GM_setClipboard(text, type)`
	end

	def add_style (text, node = nil)
		`GM_addStyle(#{text.to_s}, #{node.to_native})`
	end

	def generate_uuid
		`GM_generateUUID()`
	end

	def crypto_hash (string, algorithm = undefined, charset = undefined)
		`GM_cryptoHash(string, algorithm, charset)`
	end
end

include Scriptish
