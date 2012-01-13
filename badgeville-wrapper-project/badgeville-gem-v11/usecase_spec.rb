require 'badgeville'
require 'rspec'

describe Badgeville::Config do
  before do
    request_site  = 'http://staging.badgeville.com/'
    my_api_key     = '007857cd4fb9f360e120589c34fea080'
    Badgeville::Config.conf(:site => request_site, :api_key => my_api_key)
  end

  it "should assign the user-specified host to BaseResource.site.host" do
       Badgeville::BaseResource.site.host.should == 'staging.badgeville.com'
  end

  it "should assign the user-specified scheme to BaseResource.site.scheme" do
    Badgeville::BaseResource.site.scheme.should == 'http'
  end

  it "should contain the user-specified apikey to BaseResource.prefix" do
    Badgeville::BaseResource.prefix.should == "/api/berlin/007857cd4fb9f360e120589c34fea080/"
  end

end

