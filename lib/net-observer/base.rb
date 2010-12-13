class NetObserver::Base
  include Observable
	include Singleton

	def request_data(request,body)
		changed
		notify_observers(:request,request,body) 
	end

	def request_data(request,body)
		changed
		notify_observers(:response,request,body) 
	end
end
