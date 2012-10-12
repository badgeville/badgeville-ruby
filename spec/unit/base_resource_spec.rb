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
    # @param [Hash] options find_in_batches options
    # @return expectation of call to #find_in_batches
    def expect_find_in_batches(batches, options)
      expected_per_page = options[:batch_size] || BaseResource::BATCH_SIZE_DEFAULT
      batches.each do |page, batch|
        BaseResource.should_receive(:find).once.ordered
                    .with(:all, :params => {page: page, per_page: expected_per_page})
                    .and_return(batch)
      end
      expect { |b| BaseResource.find_in_batches(options, &b) }
    end

    [:default, 2, BaseResource::BATCH_SIZE_DEFAULT+1].product([:default, 2]).map do |batch_size, start|
      context "batch size of #{batch_size}, starting at #{start}" do
        before do
          @batch_size = (batch_size == :default) ? BaseResource::BATCH_SIZE_DEFAULT : batch_size
          @start = (start == :default) ? 1 : start

          @options = {}
          @options[:batch_size] = batch_size unless batch_size == :default
          @options[:start] = start unless start == :default
        end

        context "no resources are available" do
          before do
            @batches = {@start => []}
          end

          it "calls find once and does not yield any batches" do
            expect_find_in_batches(@batches, @options).to_not yield_control
          end
        end

        context "fewer than one batch of resources is available" do
          before do
            @batches = {@start => [0]}
          end

          it "calls find once and yields one batch" do
            expect_find_in_batches(@batches, @options).to yield_with_args(@batches[1])
          end
        end

        context "exactly one batch of resources is available" do
          before do
            @batches = {@start => [*0...@batch_size], @start+1 => []}
          end

          it "calls find twice and yields one batch" do
            expect_find_in_batches(@batches, @options).to yield_with_args(@batches[1])
          end
        end

        context "more than one batch of resources is available" do
          before do
            @batches = {@start => [*0...@batch_size], @start+1 => [@batch_size+1]}
          end

          it "calls find twice and yields two batches" do
            expect_find_in_batches(@batches, @options).to yield_successive_args(*@batches.values)
          end
        end

      end
    end
  end

  describe BaseResource, ".find_each" do
    it "passes its options hash to #find_in_batches" do
      options = {}
      BaseResource.should_receive(:find_in_batches).once.with(equal(options))
      BaseResource.find_each(options)
    end

    context "no resources are available" do
      it "does not yield any resources" do
        BaseResource.should_receive(:find_in_batches).once
        expect { |b| BaseResource.find_each(&b) }.to_not yield_control
      end
    end

    context "one batch of resources is available" do
      it "yields all resources in the batch" do
        batch = [1, 2]
        BaseResource.should_receive(:find_in_batches).once.and_yield(batch)
        expect { |b| BaseResource.find_each(&b) }.to yield_successive_args(*batch)
      end
    end

    context "more than one batch of resources is available" do
      it "yields all resources from all the batches in succession" do
        batches = [[1, 2], [3]]
        BaseResource.should_receive(:find_in_batches).once
                    .and_yield(batches[0])
                    .and_yield(batches[1])
        expect { |b| BaseResource.find_each(&b) }.to yield_successive_args(*(batches.flatten))
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