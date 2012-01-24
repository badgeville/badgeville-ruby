require "spec_helper"

module BadgevilleBerlin

  describe BaseResource, "method errors()" do

    context "the BaseResource (User) already has an associated BadgevilleBerlin::Errors object" do
      before do
        @mock_user_without_err_obj = User.new
      end
      it "should call the new method for BadgevilleBerlin::Errors, rather than ActiveResource::Errors" do
        BadgevilleBerlin::Errors.should_receive( :new )
        @mock_user_without_err_obj.errors
      end
    end

    context "the BaseResource (User) does not yet have an associated BadgevilleBerlin::Errors object" do
      before do
        @mock_user_with_errors_object = User.new
        @mock_user_with_errors_object.errors.add(:base, "Here is a mock error message string.")
      end
      it "should not call the new method for BadgevilleBerlin::Errors since an error is already saved" do
        BadgevilleBerlin::Errors.should_not_receive( :new )
      end

      it "should have the value 'Here is a mock error message string.' saved as an array element" do
         @mock_user_with_errors_object.errors.messages.should == {:base => ["Here is a mock error message string."]}
      end
    end

  end
end