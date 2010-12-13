#!/usr/bin/env ruby
require "test/unit"
require "net/http"
require "uri"
require "logger"

require "net-observer/net_logger"

class BasicTest < Test::Unit::TestCase
  def setup
  end

  def test_it_by_watching
    log = Logger.new(STDOUT)
    net_logger = NetObserver::NetLogger.new log

#    Net::Observer.log :debug
    Net::HTTP.get URI.parse("http://www.google.com/search?q=wikileaks")
#    Net::Observer.log :disable

    Net::HTTP.get URI.parse("http://www.google.com/search?q=wikipedia")
  end
end
