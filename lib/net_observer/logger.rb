require "net_observer/base"

module NetObserver
# == Logger class
# It can be used to pass network communication into logger.
# It report requests and success response as info and failed one as 
# warn message.
# @example Set simple logging to console
#   NetObserver::Logger.new Logger.new STDOUT
	class Logger
# register logger to receiving infos about network communication
# @param(Logger) logger which recieve informations about communication
		def initialize(logger)
			@logger = logger
			Base.instance.add_observer(self)
		end

# methods to receive information about connection. Needed to allow itself to register agains Base
# @see NetObserver::Base for parameters details
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

# Detaches logger from network logging
    def detach
      Base.instance.delete_observer self
    end
	end
end
