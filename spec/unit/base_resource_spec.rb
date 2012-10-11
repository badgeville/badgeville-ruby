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

    context "no resources are available" do
      it "should call find once and not yield any batches" do
        expected_find_params = {page: 1, per_page: BaseResource::PER_PAGE_DEFAULT}
        BaseResource.should_receive(:find)
                    .once
                    .with(:all, :params => expected_find_params)
                    .and_return([])
        expect { |b| BaseResource.find_in_batches(&b) }.to_not yield_control
      end
    end

    context "fewer than one batch of resources is available" do
      before do
        @batch = [0]
      end

      it "should call find once and yield one batch" do
        expected_find_params = {page: 1, per_page: BaseResource::PER_PAGE_DEFAULT}
        BaseResource.should_receive(:find)
                    .once
                    .with(:all, :params => expected_find_params)
                    .and_return(@batch)
        expect { |b| BaseResource.find_in_batches(&b) }.to yield_with_args(@batch)
      end
    end

    context "exactly one batch of resources is available" do
      before do
        @batch = [*0..49]
      end

      it "should call find twice and yield one batch" do
        {1 => @batch, 2 => []}.each do |page, batch|
          expected_find_params = {page: page, per_page: BaseResource::PER_PAGE_DEFAULT}
          BaseResource.should_receive(:find)
                      .once
                      .ordered
                      .with(:all, :params => expected_find_params)
                      .and_return(batch)
        end
        expect { |b| BaseResource.find_in_batches(&b) }.to yield_with_args(@batch)
      end
    end

    context "more than one batch of resources is available" do
      before do
        @batches = {1 => [*0..49], 2 => [50]}
      end

      it "should call find twice and yield two batches" do
        @batches.each do |page, batch|
          expected_find_params = {page: page, per_page: BaseResource::PER_PAGE_DEFAULT}
          BaseResource.should_receive(:find).once.ordered
                      .with(:all, :params => expected_find_params)
                      .and_return(batch)
        end
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