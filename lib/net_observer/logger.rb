require "net_observer/base"

module NetObserver
	class NetLogger
		def initialize(logger)
			@logger = logger
			Base.instance.add_observer(self)
		end

		def update(type, request, body, connection)
			case type
			when :response
				@logger.info "get response: #{request.inspect} with body #{body}"
			when :request
				url = "#{connection.use_ssl? ? "https" : "http"}://#{connection.address}:#{connection.port}"
				@logger.info "get request for url #{url}#{request.path} with method: #{request.method} with body #{request.body || body}"
			end
		end
	end
end
