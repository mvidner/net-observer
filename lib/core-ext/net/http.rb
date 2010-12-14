require 'net_observer/base'
require 'net/http'

module Net
  class HTTP
    alias_method :orig_request, :request

		# hook into net code to get request and response for it
    def request(req, body = nil, &block)  # :yield: +response+
      NetObserver::Base.instance.request_data(self, req, body)
      res = orig_request req, body, &block
      NetObserver::Base.instance.response_data(self, res)
      res
    end
  end
end
