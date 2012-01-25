module BadgevilleBerlin
  [Activity, ActivityDefinition, Group, Leaderboard, Player, Reward, RewardDefinition, Site, Track, User].each do |module_klass|
    klass = module_klass.to_s.split('::')[1].underscore
    describe 'Create a new ' + klass do
      before do
        @mock = Factory.build(klass)
        @mock_json = "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}" #Factory.build(klass + '_json_save')
        @path = ENDPOINTKEY + "/" + klass.pluralize + ".json"
        @method = :post
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock_json, :status => [201, "Created"]})
      end
    
      it "should make the correct http request and return the correct object." do
        @mock_http.request.should_receive(:send).with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"}).and_return(@mock_http.response)
        @mock.save()
        BadgevilleBerlin.test_attr(@mock, @mock_json)
      end
    end
    
    describe "Find a " + klass do
      before do
        @mock = Factory.build(klass)
        @mock_json = "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}" #Factory.build(klass + '_json_save')
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :get
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock_json, :status => [200, "Ok"]})
      end
    
      it "should make the correct http request and return the correct object." do
        @mock_http.request.should_receive(:send).with(@method, @path, {"Accept"=>"application/json"}).and_return(@mock_http.response)
        @mock = module_klass.find(@mock._id)
        BadgevilleBerlin.test_attr(@mock, @mock_json)
      end
    end
    
    describe "Update a " + klass do
      before do
        @mock = Factory.build(klass)
        @mock_json = "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}" #Factory.build(klass + '_json_save')
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :put
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock_json, :status => [200, "Ok"]})
        @mock.stub(:persisted?).and_return(true) # Force ActiveResource to use put
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"}).and_return(@mock_http.response)
        @mock.save()
        BadgevilleBerlin.test_attr(@mock, @mock_json)
      end
    end
    
    describe "Delete a " + klass do
      before do
        @mock = Factory.build(klass)
        @mock_json = "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}" #Factory.build(klass + '_json_save')
        @path = ENDPOINTKEY + "/" + klass.pluralize + "/" + @mock._id + ".json"
        @method = :delete
        @mock_http = MockHTTP.new(@method, @path, {:body => @mock_json, :status => [200, "Ok"]})
      end
    
      it "should make the correct http request." do
        @mock_http.request.should_receive(:send).with(@method, @path, {"Accept"=>"application/json"}).and_return(@mock_http.response)
        module_klass.delete(@mock._id)
      end
    end
  end
end