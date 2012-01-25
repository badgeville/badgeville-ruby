module BadgevilleBerlin

  describe Config, ".conf" do

    before do
      @host_name  = 'http://staging.badgeville-berlin.com'
      @my_api_key    = '007857cd4fb9f360e120589c34fea080'
      Config.conf(:host_name => @host_name, :api_key => @my_api_key)
      @empty_string = ''
    end


    context "where host name and API key are both valid" do
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


    context "where host name is empty or not given, but API key is valid" do
      it "should raise an ArgumentError with an error message" do
        lambda { Config.conf(:host_name => @empty_string, :api_key => @my_api_key) }.should raise_error(ArgumentError)
      end

      it "should raise ArgumentError" do
        lambda { Config.conf(:api_key => @my_api_key) }.should raise_error(ArgumentError)
      end
    end


    context "where API Key is empty or not given, but the host name is valid" do
      it "should raise ArgumentError" do
        lambda { Config.conf(:host_name => @host_name, :api_key => @empty_string) }.should raise_error(ArgumentError)
      end

      it "should raise ArgumentError" do
        lambda { Config.conf(:host_name => @host_name) }.should raise_error(ArgumentError)
      end
    end


    context "where neither host name or API key are given" do
      it "should raise ArgumentError" do
        lambda { Config.conf }.should raise_error(ArgumentError)
      end
    end


    context "where the :host_name has no scheme (i.e. no 'http')" do
      it "should raise ArgumentError" do
        @host_name_no_scheme  = 'staging.badgeville-berlin.com'
        lambda { Config.conf(:host_name => @host_name_no_scheme, :api_key => @my_api_key) }.should raise_error(ArgumentError)
      end
    end

  end
end