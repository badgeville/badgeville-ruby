require "spec_helper"

module BadgevilleBerlin
  describe Errors, ".from_badgeville_berlin_json" do
    before do
      @mock_user  = User.new
      @mock_error = Errors.new(@mock_user)
      Errors.stub(:new).and_return(@mock_error);
    end


    it "should handle nils" do
       @mock_error.from_badgeville_berlin_json( nil )
       @mock_error.messages.should == {}
    end


    context "without root key 'errors'" do

      it "should set error messages for errors object" do
        json_without_root_key = "{\"email\":[\"user email is already taken\"]}"
        @mock_error.from_badgeville_berlin_json( json_without_root_key )
        @mock_error.messages.should == {:base=>["Email user email is already taken"]}
      end

    end


    context "with root key 'errors'" do

      it "should set error messages for errors object" do
        json_w_root_key = "{\"errors\": {\"email\":[\"user email is already taken\"]}}"
        @mock_error.from_badgeville_berlin_json( json_w_root_key )
        @mock_error.messages.should == {:base=>["Email user email is already taken"]}
      end

      #   #(ActiveSupport::JSON.decode(json))['errors']
      #   #MultiJson::DecodeError Exception: 710: unexpected token at '{"errors": {"errors":["user email is already taken"]}'
      it "error messages should be set to empty when there is a nested key 'errors'" do
         @json_two_errors_keys = "{\"errors\": {\"errors\":[\"user email is already taken\"]}"
         @mock_error.from_badgeville_berlin_json( @json_two_errors_keys )
         @mock_error.messages.should == {}
      end
    end

  end
end