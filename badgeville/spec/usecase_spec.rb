require 'badgeville'
require 'rspec'
require 'fakeweb'

module Badgeville
  describe Config do
    before do
      base_resource = double("base_resource")
      request_site  = 'http://staging.badgeville.com/'
      my_api_key     = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:site => request_site, :api_key => my_api_key)
    end

    it "should assign the user-specified host to BaseResource.site.host" do
      BaseResource.site.host.should == 'staging.badgeville.com'
    end

    it "should assign the user-specified scheme to BaseResource.site.scheme" do
      BaseResource.site.scheme.should == 'http'
    end

    it "should contain the user-specified apikey to BaseResource.prefix" do
      BaseResource.prefix.should == "/api/berlin/007857cd4fb9f360e120589c34fea080/"
    end
  end
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

