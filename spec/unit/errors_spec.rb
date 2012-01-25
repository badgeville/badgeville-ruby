require "spec_helper"

module BadgevilleBerlin
  describe Errors, ".from_badgeville_berlin_json" do
    before do

      # Create a player and a Errors object for that player
      @mock_user = User.new
      @mock_error  = Errors.new(@mock_user)

      # Stub the new method to return the "mock" Errors object
      Errors.stub(:new).and_return(@mock_error);
    end


    context "where JSON string is missing root key 'errors'" do
      before do
        json_no_root_key = "{\"email\":[\"user email is already taken\"]}"
        @mock_error.from_badgeville_berlin_json( json_no_root_key )
      end

      it "should return a mock_error object with error messages appended" do
        @mock_error.messages.should == {:base=>["Email user email is already taken"]}
      end

      it "should return a mock_error object with error messages appended" do
        @mock_user.errors.messages.should == {:base=>["Email user email is already taken"]}
      end
    end


    context "where JSON string has a root key 'errors'" do
      before do
        json_w_root_key = "{\"errors\": {\"email\":[\"user email is already taken\"]}}"
        @mock_error.from_badgeville_berlin_json( json_w_root_key )
      end

      it "should return a mock_error object with error messages appended" do
        @mock_error.messages.should == {:base=>["Email user email is already taken"]}
      end

      it "should return a mock_error object with error messages appended" do
        @mock_user.errors.messages.should == {:base=>["Email user email is already taken"]}
      end
    end

    #   #(ActiveSupport::JSON.decode(json))['errors']
    #   #MultiJson::DecodeError Exception: 710: unexpected token at '{"errors": {"errors":["user email is already taken"]}'
    context "where  JSON string has root key 'errors', and a nested key 'errors'" do
      before do
        @json_two_errors_keys = "{\"errors\": {\"errors\":[\"user email is already taken\"]}"
        @mock_error.from_badgeville_berlin_json( @json_two_errors_keys )
      end

      it "should return a mock_error object with no error messages" do
          @mock_error.messages.should == {}
      end

      it "should return a mock_error object with no error messages" do
          @mock_user.errors.messages.should == {}
      end
    end


    context "where JSON string has root key 'errors', but the value at the key is an empty hash" do
      before do
        json_root_val_empty = "{\"errors\": {}"
        @mock_error.from_badgeville_berlin_json( json_root_val_empty )
      end

      it "should return a mock_error object with no error messages" do
        @mock_error.messages.should == {}
      end

      it "should return a mock_error object with no error messages" do
        @mock_user.errors.messages.should == {}
      end
    end


    context "where the JSON string is an empty" do
      before do
        @empty_string = ''
        @mock_error.from_badgeville_berlin_json( @empty_string )
      end

      it "should return a mock_error object with no error messages" do
        @mock_error.messages.should == {}
      end
    end

  end
end