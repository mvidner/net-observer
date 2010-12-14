#!/usr/bin/env ruby
require 'test_helper'
require "logger"
require 'mocha'
require "net_observer"

class BasicTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def test_it_by_watching
    url = "http://google.com/search?q=wikipedia"
    uri = URI.parse url
    log = Logger.new(STDOUT)
    net_logger = NetObserver::Logger.new log

    reply = File.read(File.join( File.dirname(__FILE__), "mocked_responses", "wikipedia"))
    html_body = reply[reply.index("<html>")..reply.size]
    log.expects(:info).with(regexp_matches(/get request for url http?:\/\/#{uri.host}:#{uri.port}#{uri.path}\?#{uri.query} with method: GET with body /)).once
    
    # make sure response contents are printed too
    log.expects(:warn).with(includes(html_body)).once
    
    register_fake_response :get, url , "wikipedia"

    Net::HTTP.get URI.parse(url)
  end
end
