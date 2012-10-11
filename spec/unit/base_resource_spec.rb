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

  describe BaseResource, ".find_in_batches" do

    # Set find_in_batches expectations
    #
    # @param [Hash{Integer => Array}] batches keys are expected page numbers passed to find.
    # values are expected batches returned by find for the corresponding page.
    def expect_batches(batches)
      batches.each do |page, batch|
        BaseResource.should_receive(:find).once.ordered
                    .with(:all, :params => {page: page, per_page: BaseResource::BATCH_SIZE_DEFAULT})
                    .and_return(batch)
      end
    end

    context "no resources are available" do
      it "should call find once and not yield any batches" do
        expect_batches(1 => [])
        expect { |b| BaseResource.find_in_batches(&b) }.to_not yield_control
      end
    end

    context "fewer than one batch of resources is available" do
      before do
        @batches = {1 => [0]}
      end

      it "should call find once and yield one batch" do
        expect_batches(@batches)
        expect { |b| BaseResource.find_in_batches(&b) }.to yield_with_args(@batches[1])
      end
    end

    context "exactly one batch of resources is available" do
      before do
        @batches = {1 => [*0..49], 2 => []}
      end

      it "should call find twice and yield one batch" do
        expect_batches(@batches)
        expect { |b| BaseResource.find_in_batches(&b) }.to yield_with_args(@batches[1])
      end
    end

    context "more than one batch of resources is available" do
      before do
        @batches = {1 => [*0..49], 2 => [50]}
      end

      it "should call find twice and yield two batches" do
        expect_batches(@batches)
        expect { |b| BaseResource.find_in_batches(&b) }.to yield_successive_args(*@batches.values)
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