module BadgevilleBerlin
  describe Config do
    before do
      @host_name  = 'http://staging.badgeville-berlin.com'
      @my_api_key    = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:host_name => @host_name, :api_key => @my_api_key)
      @empty_string = ''

    end

    context "with a non-empty host name a non-empty api key" do
      it "should assign the user-specified scheme to BaseResource.site.scheme" do
        BaseResource.site.scheme.should == @host_name.split('://')[0]
      end

      it "should assign the user-specified host to BaseResource.site.host" do
        BaseResource.site.host.should == @host_name.split('://')[1]
      end

      it "should contain the user-specified apikey to BaseResource.prefix" do
        BaseResource.prefix.should == "/api/berlin/#{@my_api_key}/"
      end
    end

    context "where the host name is empty, but the api key is valid" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf(:host_name => @empty_string, :api_key => @my_api_key) }.should raise_error(ArgumentError)
      end
    end

    context "where the host name is not passed in (is nil), but the api key is valid" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf(:api_key => @my_api_key) }.should raise_error(ArgumentError)
      end
    end

    context "where the API Key is empty, but the host name is valid" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf(:host_name => @host_name, :api_key => @empty_string) }.should raise_error(ArgumentError)
      end
    end

    context "where the API Key is not passed in (is nil), but the host name is valid" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf(:host_name => @host_name) }.should raise_error(ArgumentError)
      end
    end

    context "where conf is called with no parameters" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf }.should raise_error(ArgumentError)
      end
    end

  end

  describe Config, "where the host name has no scheme" do
    context "where the :host_name has no scheme (i.e. no 'http')" do
      before do
      @host_name_no_scheme  = 'staging.badgeville-berlin.com'
      @my_api_key   = '007857cd4fb9f360e120589c34fea080'
      end
    end

    it "should raise an ArgumentError with an error message" do
      lambda { Config.conf(:host_name => @host_name_no_scheme, :api_key => @my_api_key) }.should raise_error(ArgumentError)
    end
  end
end