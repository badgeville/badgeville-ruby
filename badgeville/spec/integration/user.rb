require 'badgeville'
require 'rspec'
require 'ruby-debug'
require 'fakeweb'
require 'factory_girl'
require 'ruby-debug'
require 'factories.rb'


module Badgeville

  Config.conf(:site => 'http://staging.badgeville.com/', :api_key => '007857cd4fb9f360e120589c34fea080')
  FakeWeb.allow_net_connect = false # Requests to a URI you haven’t registered with #register_uri, a NetConnectNotAllowedError will be raised


  describe 'Create a new user' do
    before do

      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/users.json"
      @port = "80"

      @user = {
        :email => 'visitor@emailserver.com',
        :name => 'visitor_username',
        :network_id => '4d5dc61ed0c0b32b79000001',
        :password => 'visitor_password'
      }

      FakeWeb.register_uri(
        :post,
        "http://" + BaseResource.site.host + ":" + @port + @path,
        {:body => "{\"user\":" + @user.to_json + "}", :status => [201, "Created"]}
      )
    end

    it "should make the correct http request" do

      mock_http = Net::HTTP.new(BaseResource.site.host, @port)
      Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(@port)).and_return(mock_http)

      mock_http_ok = mock_http.send(:post, @path, {"Accept"=>"application/json"})
      mock_http.should_receive(:send)
        .with(:post, @path, "{\"user\":" + @user.to_json + "}", {"Content-Type"=>"application/json"})
        .and_return(mock_http_ok)

      User.new(@user).save()
    end
  end

  describe 'Update a user' do
    before do

      @user = {
        :_id => "4f05ef5ea768651b3500009f",
        :email => "visitor@emailserver.com",
        :name => "visitor_username",
        :network_id => "4d5dc61ed0c0b32b79000001",
        :password => "visitor_password"
      }

      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/users/" + @user[:_id] + ".json"
      @port = "80"

      FakeWeb.register_uri(
        :put,
        "http://" + BaseResource.site.host + ":" + @port + @path,
        {:body => "{\"user\":" + @user.to_json + "}", :status => [201, "Created"]}
      )
    end

    it "should make the correct http request" do

      mock_http = Net::HTTP.new(BaseResource.site.host, @port)
      Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(@port)).and_return(mock_http)

      mock_http_ok = mock_http.send(:put, @path, {"Accept"=>"application/json"})
      mock_http.should_receive(:send)
        .with(:put, @path, "{\"user\":" + @user.to_json + "}", {"Content-Type"=>"application/json"})
        .and_return(mock_http_ok)

      u = User.new(@user).save()
      u.email = 'visitor@emailserver.com'
      u.save
    end
  end
end