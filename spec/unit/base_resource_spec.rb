require "spec_helper"
require 'factories'

module BadgevilleBerlin

  describe BaseResource, ".errors" do
    before do
      @mock_user_without_err_obj = User.new
      @mock_user_with_errors_obj = User.new
      @mock_user_with_errors_obj.errors.add(:base, "Mock error string.")
    end

    context "BaseResource has associated BadgevilleBerlin::Errors object" do
      it "should call .new from BadgevilleBerlin::Errors (not from ActiveResource::Errors)" do
        BadgevilleBerlin::Errors.should_receive( :new )
        @mock_user_without_err_obj.errors
      end
    end

    context "BaseResource does not have associated BadgevilleBerlin::Errors object" do
      it "should not call .new for BadgevilleBerlin::Errors" do
        BadgevilleBerlin::Errors.should_not_receive( :new )
        @mock_user_with_errors_obj.errors
      end
    end

  end

  #describe BaseResource, ".encode" do
  #  before do
  #    @mock_activity_definition = Factory.create(:activity_definition)
  #    @mock_activity_definition.selector = {:verb => "comment"}
  #    @mock_activity_definition.adjustment = {:points => 5 }
  #  end
  #
  #  context "BaseResource passes correct arguments to send method" do
  #    it "should call sanitize request and update record." do
  #      @mock_activity_definition.bucket_drain_rate = 180
  #      debugger
  #      @path = ENDPOINTKEY + "/activity_definitions/" + @mock_activity_definition._id + ".json"
  #      FakeWeb.allow_net_connect = false
  #
  #      @mock_activity_definition.should_receive(:sanitize_request)
  #      @mock_http = MockHTTP.new(:put, @path, {:body => BadgevilleBerlin.response_json["valid_activity_definition_update"], :status => [200, "Ok"]})
  #      @mock_activity_definition.save()
  #    end
  #  end
  #
  #end

end