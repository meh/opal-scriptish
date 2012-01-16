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

class Response
	def initialize (object)
		@native = object
	end

	def text
		`#@native.responseText`
	end

	def json
		`#@native.responseJSON`
	end

	def headers
		Hash(`#@native.responseHeaders`)
	end

	def status
		Struct.new(:code, :text).new(`#@native.status`, `#@native.statusText`)
	end

	def url
		`#@native.finalUrl`
	end

	def abort
		`#@native.abort()`
	end
end

class Request
	attr_accessor :method, :data, :headers, :user, :password, :mime_type, :limit
	attr_reader   :url

	def initialize (url)
		@url    = url
		@method = :get
		@ignore = []

		yield self if block_given?
	end

	def start
		Response.new(`GM_xmlhttpRequest(#{to_native})`)
	end

	%[load error state_change].each {|name|
		define_method name do |&block|
			raise ArgumentError, 'no block has been passed' unless block

			instance_variable_set "@#{name}", proc {|response|
				block.call(Response.new(response))
			}
		end

		alias_method "on_#{name}", name
	}

	def ignore (what)
		@ignore.push(what.to_s.downcase.to_sym)
		@ignore.uniq!
	end

	def to_hash
		{
			method:                  @method.to_s.upcase,
			url:                     @url.to_s,
			onload:                  @load,
			onerror:                 @error,
			onreadystatechange:      @state_change,
			data:                    @data,
			headers:                 @headers,
			binary:                  @binary,
			user:                    @user,
			password:                @password,
			overrideMimeType:        @mime_type,
			ignoreCache:             @ignore.include?(:cache),
			ignoreRedirect:          @ignore.include?(:redirect),
			ignoreTempRedirect:      @ignore.include?(:temporary_redirect),
			ignorePermanentRedirect: @ignore.include?(:permanent_redirect),
			redirectionLimit:        @limit
		}
	end

	def to_native
		to_hash.to_native
	end
end

end
