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
  
  
  describe 'Create a new site' do
    before do
      
      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/sites.json"
      @port = "80"
      @site = {
        :name => "My Website",
        :network_id => '4d5dc61ed0c0b32b79000001',
        :url => "mydeeeomain.com"
      }
           
      FakeWeb.register_uri(
        :post,
        "http://" + BaseResource.site.host + ":" + @port + @path,
        {:body => "{\"site\":" + @site.to_json + "}", :status => [201, "Created"]}
      )
    end
    
    it "should make the correct http request" do

      mock_http = Net::HTTP.new(BaseResource.site.host, @port)
      Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(@port)).and_return(mock_http)
      
      mock_http_ok = mock_http.send(:post, @path, {"Accept"=>"application/json"})
      mock_http.should_receive(:send)
        .with(:post, @path, "{\"site\":" + @site.to_json + "}",  {"Content-Type"=>"application/json"})
        .and_return(mock_http_ok)
        
      Site.new(@site).save()
    end
  end
end