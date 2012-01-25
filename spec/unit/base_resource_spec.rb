require "spec_helper"

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
end