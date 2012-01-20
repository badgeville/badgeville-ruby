require 'rspec'
require 'badgeville'
require 'fakeweb'
require 'factory_girl'
require 'factories'

module Badgeville
  
  Config.conf(:site => 'http://staging.badgeville.com/', :api_key => '007857cd4fb9f360e120589c34fea080')
  FakeWeb.allow_net_connect = false # Requests to a URI you haven’t registered with #register_uri, a NetConnectNotAllowedError will be raised
  
  class MockHTTP
    attr_accessor :request, :response

    def initialize(method, path, options)
      port = "80"
      # URI must be registered to prevent fail
      FakeWeb.register_uri(method, "http://" + BaseResource.site.host + ":" + port + path, options)
      
      # Mocks
      @request = Net::HTTP.new(BaseResource.site.host, port)
      @response = @request.send(method, path, {"Accept"=>"application/json"})
      
      # Force Net::HTTP.new to return @request
      Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(port)).and_return(@request)
    end
  end
  
  
end