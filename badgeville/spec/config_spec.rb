require 'rspec'
require 'badgeville'

module Badgeville
  describe Config do
    context "with a non-empty request site a non-empty api key"
    before do
      @request_site  = 'http://staging.badgeville.com'
      @my_api_key     = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:site => @request_site, :api_key => @my_api_key)
    end

    it "should assign the user-specified host to BaseResource.site.host" do
      BaseResource.site.host.should == @request_site.split('://')[1]
    end

    it "should assign the user-specified scheme to BaseResource.site.scheme" do
      BaseResource.site.scheme.should == @request_site.split('://')[0]
    end

    it "should contain the user-specified apikey to BaseResource.prefix" do
      BaseResource.prefix.should == "/api/berlin/007857cd4fb9f360e120589c34fea080/"
    end

    context "where the request site is empty"
    before do
      @request_site_empty  = ''
    end

    it "should raise an ArgumentError with the message 'Please enter a valid Badgeville API Key.'" do
      lambda { Config.conf(:site => @request_site_empty, :api_key => @my_api_key) }.should raise_error(ArgumentError)
    end

    context "where the request site is nil"
    before do
      @request_site_empty  = nil
      @my_api_key          = '007857cd4fb9f360e120589c34fea080'
    end

    # it "should raise an ArgumentError with the message 'Please enter a valid Badgeville API Key.'" do
    #   lambda { Config.conf(:site => @request_site, :api_key => @my_api_key) }.should raise_error(ArgumentError)
    # end

  end
end