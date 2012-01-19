require 'badgeville'
require 'rspec'
require 'ruby-debug'
require 'fakeweb'
require 'factory_girl'
require 'ruby-debug'
require 'factories.rb'


module Badgeville
  
  Config.conf(:site => 'http://staging.badgeville.com/', :api_key => '007857cd4fb9f360e120589c34fea080')
  #FakeWeb.allow_net_connect = false # Requests to a URI you haven’t registered with #register_uri, a NetConnectNotAllowedError will be raised
  
  
  describe 'Create a new site' do
    before do

      debugger
      @site = Factory.build(:player)
      
      #@path = "/api/berlin/007857cd4fb9f360e120589c34fea080/players.json"
      #@port = "80"
           
      #FakeWeb.register_uri(:get, "http://" + BaseResource.site.host + ":" + @port + @path, {:body => "{\"data\":[],\"paging\":{\"current_page\":1,\"per_page\":10}}"} )
    end
    
    it "should make the correct http request" do

      # mock_http = Net::HTTP.new(BaseResource.site.host, @port)
      # Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(@port)).and_return(mock_http)
      # 
      # mock_http_ok = mock_http.send(:get, @path , {"Accept"=>"application/json"})
      # mock_http.should_receive(:send)
      #   .with(:get, @path,  {"Accept"=>"application/json"})
      #   .and_return(mock_http_ok)
        
      #Create a new site. (new_site = Site.new( :name => "My Website", :url => "mydomain.com", :network_id => '4d5dc61ed0c0b32b79000001' )
      Site.new( :name => "My Website", :url => "mydomain.com", :network_id => '4d5dc61ed0c0b32b79000001' ).save()
    end
  end
  
  # describe 'Find all players' do
  #   before do
  #     @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/players.json"
  #     @port = "80"
  #          
  #     FakeWeb.register_uri(:get, "http://" + BaseResource.site.host + ":" + @port + @path, {:body => "{\"data\":[],\"paging\":{\"current_page\":1,\"per_page\":10}}"} )
  #   end
  #   
  #   it "should make the correct http request" do
  # 
  #     mock_http = Net::HTTP.new(BaseResource.site.host, @port)
  #     Net::HTTP.should_receive(:new).with(BaseResource.site.host, Integer(@port)).and_return(mock_http)
  #     
  #     mock_http_ok = mock_http.send(:get, @path , {"Accept"=>"application/json"})
  #     mock_http.should_receive(:send)
  #       .with(:get, @path,  {"Accept"=>"application/json"})
  #       .and_return(mock_http_ok)
  #       
  #     Player.find(:all)
  #   end
  # end
end