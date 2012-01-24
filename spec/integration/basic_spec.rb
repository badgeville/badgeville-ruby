require 'active_support/inflector'

module BadgevilleBerlin
  [Activity, ActivityDefinition, Group, Leaderboard, Player, Reward, RewardDefinition, Site, Track, User].each do |module_klass|
    klass = module_klass.to_s.split('::')[1].underscore
    
    describe 'Create a new ' + klass do
      before do
        @mock = Factory.build(klass)
        @path = ENDPOINTKEY + "/" + klass.pluralize + ".json"
        @method = :post
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [201, "Created"]})
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"}).and_return(@mock_http.response)
        @mock.save()
      end
    end
    
    describe "Find a " + klass do
      before do
        @mock = Factory.build(klass)
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :get
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [200, "Ok"]})
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, {"Accept"=>"application/json"}).and_return(@mock_http.response)
        module_klass.find(@mock._id)
      end
    end
    
    describe "Update a " + klass do
      before do
        @mock = Factory.build(klass)
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :put
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [200, "Ok"]})
        @mock.stub(:persisted?).and_return(true) # Force ActiveResource to use put
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"}).and_return(@mock_http.response)
        @mock.save()
      end
    end
    
    describe "Delete a " + klass do
      before do
        @mock = Factory.build(klass)
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :delete
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [200, "Ok"]})
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, {"Accept"=>"application/json"}).and_return(@mock_http.response)
        module_klass.delete(@mock._id)
      end
    end
  end
end