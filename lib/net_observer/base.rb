require "observer"
require "singleton"
require "core-ext/net/http"

module NetObserver
# == Base Class ==
#
# Basic object for observing network communication. It is singleton, as it doesn't make sense to have more then one
# object which observe network. Object is observable, so anyone could attach own object which contain update method 
# for all network objects.
#
# Parameters for update command in observers:
#
# @param(Symbol) type of request, can be :request or :response
#
# @param(Net::HttpRequest) request send or received from network
#
# @param(String) body body used/received in request
#
# @param(Net::HTTP,Net::HTTPS) connection connection on which is called method
#
# @see NetObserver::Logger for example usage
	class Base
  	include Observable
		include Singleton

		# @private
		# internal method for network hook
		def request_data(connection, request,body)
			changed
			notify_observers(:request,request,body, connection)
		end
		# @private
		# internal method for network hook
		def response_data(connection, response)
			changed
			body = response.respond_to?(:body) ? response.body : ""
			notify_observers(:response,response,body, connection)
		end
	end
end
