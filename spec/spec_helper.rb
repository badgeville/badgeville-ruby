require 'rubygems'
require 'rspec'
require 'fakeweb'
require 'factory_girl'
require 'active_support/inflector'
require 'logger'
require_relative '../lib/badgeville-berlin'
require_relative 'factories'

module BadgevilleBerlin
  @@response_json = Yaml::load("spec/response_json.yml")
  
  def response_json
    @@response_json
  end
  
  HOST = "staging.badgeville.com"
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"
  ENDPOINTKEY = ENDPOINT + APIKEY
  PORT = "80"

  FakeWeb.allow_net_connect = false # Requests to a URI you haven’t registered with #register_uri, a NetConnectNotAllowedError will be raised
  Config.conf(:host_name => 'http://' + HOST + '/', :api_key => APIKEY)

  # Instantiate a logger so HTTP request and response information will be
  # printed to STDOUT.
  BaseResource.logger       = Logger.new(STDOUT)
  BaseResource.logger.level = Logger::DEBUG

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

  def self.test_attr (mock, mock_json)
    attributes = mock.instance_variable_get("@attributes")
    JSON.parse(mock_json)["data"].each do |key, value|
      value.should == attributes[key]
    end
  end

end