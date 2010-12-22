require "net_observer/base"
require "singleton"

module NetObserver
# == Last Request class
# Its main purpose is to remember last request send via network.
# @example Enable last request and print it when Connection Error appear
#   NetObserver::LastRequest.instance.enable
#   begin
#     ..
#   rescue ActiveResource::ConnectionError => e
#     last_request = NetObserver::LastRequest.instance.last_request
#     site = "#{last_request[:connection].use_ssl? ? "https" : "http"}://"+last_request[:connection].address
#     log.error "Job failed due to communication problem with #{site}."
#     log.error "Request: path: #{last_request[:request].path} with body #{last_request[:body]}."
#     log.error "Response: #{e.inspect} with body #{e.response.body}."
#   end
	class LastRequest
		include Singleton
#last request sent via network
		attr_reader :last_request
# Enable storing last request
		def enable
			@last_request = nil
			Base.instance.add_observer(self)
		end

# Disable storing requests
		def disable
			@last_request = nil
			Base.instance.delete_observer(self)
		end

# methods to receive information about connection. Needed to allow itself to register agains Base
# @see NetObserver::Base for parameters details
		def update(type, request, body, connection)
			case type
			when :response
				return #don't care
			when :request
				@last_request = { :connection => connection, :request => request, :body => (request.body || body)}
			end
		end
	end
end
