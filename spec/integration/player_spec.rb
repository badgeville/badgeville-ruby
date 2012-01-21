require "spec_helper"


module Badgeville
  describe 'Find all players' do
    before do
      @mock = {
        :data => [],
        :paging => {
          :current_page => 1,
          :per_page => 10
        }
      }
      @path = "/api/berlin/007857cd4fb9f360e120589c34fea080/players.json"
      @method = :get
      @json =  @mock.to_json
      @mock_http = MockHTTP.new(@method, @path, {:body => @json, :status => [200, "Ok"]})
    end
    
    it "should make the correct http request" do
      @mock_http.request.should_receive(:send)
        .with(@method, @path, {"Accept"=>"application/json"})
        .and_return(@mock_http.response)
      Player.find(:all)
    end
  end
end