require "observer"
require "singleton"
require "core-ext/net/http"

module NetObserver
	class Base
  	include Observable
		include Singleton

		def request_data(request,body)
			changed
			notify_observers(:request,request,body) 
		end

		def response_data(response)
			changed
			body = response.respond_to?(:body) ? response.body : ""
			notify_observers(:response,response,body) 
		end
	end
end
