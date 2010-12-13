require 'net-observer/base'
require 'net/http'

module Net
  class HTTP
    alias_method :orig_request, :request

    def request(req, body = nil, &block)  # :yield: +response+
      begin
        NetObserver::Base.instance.request_data(req, body)
        res = orig_request req, body, &block
      rescue => e
        puts "something went wrong: #{e.message}"
        raise e
      end
      NetObserver::Base.instance.response_data(res)
      res
    end
  end
end
