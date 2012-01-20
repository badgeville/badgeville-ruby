require 'rspec'
require 'badgeville'
require 'ruby-debug'

module Badgeville
  describe BaseResource do
    before do
      @mock_user_without_err_obj = User.new
      p @mock_user_without_err_obj
    end
    it "should return an object of type Badgeville::Errors, rather than ActiveResource::Errors" do
      Badgeville::Errors.should_receive( :new )
      @mock_user_without_err_obj.errors
    end

    before do
      debugger

      @mock_user_with_errors_object = User.new
      @mock_user_with_errors_object.errors = "Here is a mock error message string."
      # Figure out the correct way to set a mock error message
    end
  end
end