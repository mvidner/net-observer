require "observer"
require "singleton"
require "core-ext/net/http"

module NetObserver
	class Base
  	include Observable
		include Singleton

		def request_data(connection, request,body)
			changed
			notify_observers(:request,request,body, connection) 
		end

		def response_data(connection, response)
			changed
			body = response.respond_to?(:body) ? response.body : ""
			notify_observers(:response,response,body, connection) 
		end
	end
end
