require "net_observer/base"

module NetObserver
	class Logger
		def initialize(logger)
			@logger = logger
			Base.instance.add_observer(self)
		end

		def update(type, request, body, connection)
			case type
			when :response
				method = request.kind_of?(Net::HTTPSuccess) ? :info : :warn
				@logger.send method, "get response: #{request.inspect} with body #{body}"
			when :request
				port = ""
				port = ":#{connection.port}" if (connection.port.to_i != (connection.use_ssl? ? 443 : 80))
				url = "#{connection.use_ssl? ? "https" : "http"}://#{connection.address}#{port}"
				@logger.info "get request for url #{url}#{request.path} with method: #{request.method} with body #{request.body || body}"
			end
		end
	end
end
