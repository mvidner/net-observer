#!/usr/bin/env ruby
require 'rubygems'
require 'mocha'
require File.join File.dirname(__FILE__),'test_helper'
require "logger"
require "net_observer"

class BasicTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def test_simple_request
    assert_nothing_raised do
      url = "http://google.com/search?q=wikipedia"
      log = Logger.new(STDOUT)
      net_logger = NetObserver::Logger.new log

      reply = File.read(File.join( File.dirname(__FILE__), "mocked_responses", "wikipedia"))
      html_body = reply[reply.index("<html>")..reply.size]
      log.expects(:info).with("get request for url #{url} with method: GET with body ").once
      
      # make sure response contents are printed too
      log.expects(:warn).with() do |value|
        value.include?(html_body)
      end
      
      register_fake_response :get, url , "wikipedia"

      Net::HTTP.get URI.parse(url)
      net_logger.detach
    end
  end
end
