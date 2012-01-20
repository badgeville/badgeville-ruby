require 'rspec'
require 'badgeville'
require 'ruby-debug'

module Badgeville
  describe Config do
    before do
      @request_site  = 'http://staging.badgeville.com'
      @my_api_key   = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:site => @request_site, :api_key => @my_api_key)
      @empty_string = ''
    end

    context "with a non-empty request site a non-empty api key" do

      it "should assign the user-specified scheme to BaseResource.site.scheme" do
        BaseResource.site.scheme.should == @request_site.split('://')[0]
      end

      it "should assign the user-specified host to BaseResource.site.host" do
        BaseResource.site.host.should == @request_site.split('://')[1]
      end

      it "should contain the user-specified apikey to BaseResource.prefix" do
        BaseResource.prefix.should == "/api/berlin/#{@my_api_key}/"
      end


      context "where the request site is empty, but the api key is valid" do
        it "should raise an ArgumentError with an error message" do
          lambda { Config.conf(:site => @empty_string, :api_key => @my_api_key) }.should raise_error(ArgumentError)
        end
      end

      context "where the request site is not passed in (is nil), but the api key is valid" do
        it "should raise an ArgumentError with an error message" do
          lambda { Config.conf(:api_key => @my_api_key) }.should raise_error(ArgumentError)
        end
      end

      context "where the API Key is empty, but the request site is valid" do
        it "should raise an ArgumentError with an error message" do
          lambda { Config.conf(:site => @request_site, :api_key => @empty_string) }.should raise_error(ArgumentError)
        end
      end

      context "where the API Key is not passed in (is nil), but the request site is valid" do
        it "should raise an ArgumentError with an error message" do
          lambda { Config.conf(:site => @request_site) }.should raise_error(ArgumentError)
        end
      end

      context "where conf is called with no parameters" do
        it "should raise an Argument error with an error message" do
          lambda { Config.conf }.should raise_error(ArgumentError)
        end
      end

    end
  end

  describe Config, "where site has no scheme" do
    context "where the request site has no scheme (i.e. no 'http')" do
      before do
      @request_site_no_scheme  = 'staging.badgeville.com'
      @my_api_key   = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:site => @request_site_no_scheme, :api_key => @my_api_key)
      end
    end

    it "should assign the default scheme 'http' to BaseResource.site.scheme" do
      BaseResource.site.scheme.should == 'http'
    end
  end
end