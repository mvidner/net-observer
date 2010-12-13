#!/usr/bin/env ruby
require "test/unit"
require "net/http"
require "net-observer"

class BasicTest < Test::Unit::TestCase
  def setup
  end

  def test_it
    Net::HTTP.get_print "http://www.google.com/search?q=wikileaks"
  end
end
