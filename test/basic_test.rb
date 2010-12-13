#!/usr/bin/env ruby
require 'test_helper'
require "net/http"
require "uri"
require "logger"

require "net-observer/net_logger"

class BasicTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def test_it_by_watching
    log = Logger.new(STDOUT)
    net_logger = NetObserver::NetLogger.new log

    register_fake_response :get, "http://www.google.com/search?q=wikipedia",
                           "wikipedia"

    Net::HTTP.get URI.parse("http://www.google.com/search?q=wikipedia")
  end
end
