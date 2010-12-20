$LOAD_PATH << (File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require "test/unit"
require 'fakeweb'

class Test::Unit::TestCase
  def register_fake_response type, url, response_file=nil
    response_file = url if response_file.nil?
    response = File.read(File.join( File.dirname(__FILE__), 
                                    "mocked_responses", response_file))
    FakeWeb.register_uri(type, url, :response => response)
  end
end
