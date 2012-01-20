require "spec_helper"


module Badgeville
  describe 'Create a new user' do
    before do
      @mock = {
        :email => 'visitor@emailserver.com',
        :name => 'visitor_username',
        :network_id => '4d5dc61ed0c0b32b79000001',
        :password => 'visitor_password'
      }
      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/users.json"
      @method = :post
      @json =  "{\"user\":" + @mock.to_json + "}"
      @mock_http = MockHTTP.new(@method, @path, {:body => @json, :status => [201, "Created"]})
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, @json, {"Content-Type"=>"application/json"})
        .and_return(@mock_http.response)
  
      User.new(@mock).save()
    end
  end
  
  describe 'Find a user' do
    before do
      @mock = {
        :_id => "4f05ef5ea768651b3500009f",
        :name => "visitor_username",
        :created_at => '2012-01-05T10:43:42-08:00',
        :email => "revised_visitor@emailserver.com"
      }
      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/users/" + @mock[:_id] + ".json"
      @method = :get
      @json =  "{\"user\":" + @mock.to_json + "}"
      @mock_http = MockHTTP.new(@method, @path, {:body => @json, :status => [200, "Ok"]})
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, {"Accept"=>"application/json"})
        .and_return(@mock_http.response)
      
      User.find(@mock[:_id])
    end
  end
  
  describe 'Update a user' do
    before do
      @mock = {
        :_id => "4f05ef5ea768651b3500009f",
        :created_at => '2012-01-05T10:43:42-08:00',
        :email => "revised_visitor@emailserver.com",  
        :name => "visitor_username"
      }
      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/users/" + @mock[:_id] + ".json"
      @method = :put
      @json =  "{\"user\":" + @mock.to_json + "}"
      @mock_http = MockHTTP.new(@method, @path, {:body => @json, :status => [200, "Ok"]})
    end
  
    it "should make the correct http request." do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, @json, {"Content-Type"=>"application/json"})
        .and_return(@mock_http.response)
      
      User.new(@mock, true).save()
    end
  end
end