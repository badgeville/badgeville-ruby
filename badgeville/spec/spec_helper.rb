require 'rspec'
require 'badgeville'
require 'ruby-debug'
require 'fakeweb'
require 'factory_girl'
require 'factories'

module Badgeville
  
  HOST = "staging.badgeville.com" 
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"
  ENDPOINTKEY = ENDPOINT + APIKEY
  PORT = "80"
  
  FakeWeb.allow_net_connect = false # Requests to a URI you haven’t registered with #register_uri, a NetConnectNotAllowedError will be raised
  Config.conf(:site => 'http://' + HOST + '/', :api_key => APIKEY)
  
  class MockHTTP
    attr_accessor :request, :response

    def initialize(method, path, options)
      # URI must be registered to prevent fail
      FakeWeb.register_uri(method, "http://" + HOST + ":" + PORT + path, options)
      # Mocks
      @request = Net::HTTP.new(HOST, PORT)
      @response = @request.send(method, path, {"Accept"=>"application/json"})
      
      # Force Net::HTTP.new to return @request
      Net::HTTP.should_receive(:new).with(HOST, Integer(PORT)).and_return(@request)
    end
  end 
  
end