#!/usr/bin/env ruby
require 'rubygems'
require 'mocha'
require File.join File.dirname(__FILE__),'test_helper'
require "net_observer"

class LastRequestTest < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end

  def test_request_url
    assert_nothing_raised do
      url = "http://google.com/search?q=wikipedia"
			NetObserver::LastRequest.instance.enable

      register_fake_response :get, url , "wikipedia"

      Net::HTTP.get URI.parse(url)

			last_request = NetObserver::LastRequest.instance.last_request
			site = "#{last_request[:connection].use_ssl? ? "https" : "http"}://#{last_request[:connection].address}"
			assert_equal url, site+last_request[:request].path
    end
  end

  def test_stop_catching_request
    assert_nothing_raised do
      url = "http://google.com/search?q=wikipedia"
			NetObserver::LastRequest.instance.enable

      register_fake_response :get, url , "wikipedia"

      Net::HTTP.get URI.parse(url)

			last_request = NetObserver::LastRequest.instance.last_request
			assert_not_nil last_request

      NetObserver::LastRequest.instance.disable
      Net::HTTP.get URI.parse(url)
			last_request = NetObserver::LastRequest.instance.last_request
			assert_nil last_request

    end
  end
	
end
