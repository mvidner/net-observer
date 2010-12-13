module NetObserver
	class NetLogger
		def initialize(logger)
			@logger = logger
			Base.instance.add_observer(self)
		end

		def update(type, request, body)
			@logger.info "get #{type}: #{request.inspect} with body #{body}"
		end
	end
end
