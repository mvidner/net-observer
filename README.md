Description
-----------

Net Observer lets you observe outgoing Net::HTTP requests that your
Ruby application makes. This can be useful when it fails at the remote
end and you want to report the exact request that caused the problem.

Documentation
-------------

Create a `NetObserver::Logger` instance to log the requests and
reponse.  Use the `NetObserver::Base` class to observe the requests in
another way.

Examples
--------

This:

    require "net_observer"
    require "logger"

    log = Logger.new(STDOUT)
    net_logger = NetObserver::Logger.new log
    Net::HTTP.get URI.parse("http://google.com/search?q=wikipedia")

produces:

    I, [2010-12-14T12:42:50.570907 #23968]  INFO -- : get request for url http://google.com:80/search?q=wikipedia with method: GET with body 
    W, [2010-12-14T12:42:50.579045 #23968]  WARN -- : get response: #<Net::HTTPForbidden 403 Forbidden readbody=true> with body <html><head>[...]

Development
-----------

NetObserver was conceived by [Josef Reidinger](mailto:jreidinger@suse.cz).

The repository is at GitHub: <https://github.com/mvidner/net-observer>.
