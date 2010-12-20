require "net_observer/base"
require "singleton"

module NetObserver
# == Logger class
# It can be used to pass network communication into logger.
# It report requests and success response as info and failed one as 
# warn message.
# @example Set simple logging to console
#   NetObserver::Logger.new Logger.new STDOUT
	class LastRequest
		include Singleton
		attr_reader :last_request
# register logger to receiving infos about network communication
# @param(Logger) logger which recieve informations about communication
		def enable
			@last_request = nil
			Base.instance.add_observer(self)
		end

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
