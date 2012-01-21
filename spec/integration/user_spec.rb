module Badgeville
  describe 'Create a new user' do
    before do
      @mock = Factory.build(:user)
      @path = ENDPOINTKEY + "/users.json"
      @method = :post
      @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [201, "Created"]})
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"})
        .and_return(@mock_http.response)
      
      @mock.save()
    end
  end
  
  describe 'Find a user' do
    before do
      @mock = Factory.build(:player)
      @path = ENDPOINTKEY + "/users/" + @mock._id + ".json"
      @method = :get
      @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [200, "Ok"]})
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, {"Accept"=>"application/json"})
        .and_return(@mock_http.response)
      
      User.find(@mock._id)
    end
  end
  
  describe 'Update a user' do
    before do
      @mock = Factory.build(:user)
      @path = ENDPOINTKEY + "/users/" + @mock._id + ".json"
      @method = :put
      @mock_http = MockHTTP.new(@method, @path, {:body => @mock.to_json, :status => [200, "Ok"]})
      @mock.stub(:persisted?).and_return(true) # Force ActiveResource to use put
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, @mock.to_json, {"Content-Type"=>"application/json"})
        .and_return(@mock_http.response)
      @mock.save()
    end
  end
end