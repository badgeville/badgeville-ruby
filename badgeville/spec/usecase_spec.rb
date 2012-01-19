require 'badgeville'
require 'rspec'
require 'fakeweb'
require 'open-uri'
require 'factory_girl'
require 'ruby-debug'

#placing this here because factories.rb is not read
FactoryGirl.define do
  factory :player do
    email 'supraja220494@badgeville.com'
    id '4f0b29bca76865329a0000ae'
  end
end

module Badgeville
  
  describe 'Config' do
    before do
       @request_site  = 'http://staging.badgeville.com'
       @my_api_key    = '007857cd4fb9f360e120589c34fea080'
       Config.conf(:site => @request_site, :api_key => @my_api_key)
    end

    it "should assign the user-specified host to BaseResource.site.host" do
      BaseResource.site.host.should == @request_site.split("://")[1]
    end

    it "should assign the user-specified scheme to BaseResource.site.scheme" do
      BaseResource.site.scheme.should == @request_site.split("://")[0]
    end

    it "should contain the user-specified apikey to BaseResource.prefix" do
      BaseResource.prefix.should == "/api/berlin/#{@my_api_key}/"
    end
  end
  
  describe 'Player.first' do
    before do
      #FakeWeb.register_uri(:get, "http://staging.badgeville.com:80/api/berlin/007857cd4fb9f360e120589c34fea080/players.json", :body => "{}")
    end
    
    it "should make an http request" do
      mock_http = Net::HTTP.new("staging.badgeville.com", "80")
      Net::HTTP.should_receive(:new).with("staging.badgeville.com", 80).and_return(mock)
    
      mock_http_ok = mock.send(:get, "/api/berlin/007857cd4fb9f360e120589c34fea080/players.json", {"Accept"=>"application/json"})
      mock.should_receive(:send).at_least(:once)
        .with(:get, "/api/berlin/007857cd4fb9f360e120589c34fea080/players.json",  {"Accept"=>"application/json"})
        .and_return(mock_http_ok)
      Player.find(:all);
    end
  end
  
  # describe 'BadgevilleJsonFormat' do
  #   before do
  #     @hash = {data => {"a" => 100, "b" => 200}};
  #     @json = BadgevilleJsonFormat.encode(@hash)
  #     @decodedHash = BadgevilleJsonFormat.decode(@json)
  #   end
  #   
  #   it "encode should produce json string" do
  #     @json.should == "{\"data\":{\"a\":100,\"b\":200}}"
  #   end
  #   
  #   it "decode should produce ruby object" do
  #     debugger
  #     @decodedHash.should == {"a" => 100, "b" => 200}
  #   end  
  # end
  
end
 #  describe Site do
 #     before do
 #        request_site  = 'http://staging.badgeville.com/'
 #        my_api_key   = '007857cd4fb9f360e120589c34fea080'
 #        Config.conf(:site => request_site, :api_key => my_api_key)
 #        p BaseResource.site
 #        @s = Site.new
 #     end
 #     it "should receive the save() method" do
 #       @s.should_receive(:new)
 #     end
 #   end
 # end

# describe Site do
#   before do
#     request_site  = 'http://staging.badgeville.com/'
#     my_api_key     = '007857cd4fb9f360e120589c34fea080'
#
#     BaseResource::Config.conf(:site => request_site, :api_key => my_api_key)
#     @s = Site.new
#     @s.save
#     puts request_site
#   end
#   it "should receive the save() method" do
#     @s.should_receive(:new)
#   end
# end

# describe ActiveResource::Connection do
#   before do
#     @s = Site.first
#     p @s.send(:connection)
#   end
#   it "should receive the build_request_headers() method" do
#     #@s.connection.should_receive(:build_request_headers)
#     debugger
#     @s.send(:connection).should_receive(:new)
#     #.with('get', 'http://staging.badgeville.com/api/berlin/007857cd4fb9f360e120589c34fea080/sites.json')
#   end
# end
#

