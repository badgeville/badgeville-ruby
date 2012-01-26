require 'spec_helper'

module BadgevilleBerlin
  describe "README use case example set" do
    before(:all) do
      # Initializations
      @rand1 = rand(5000)
      @rand2 = rand(5000)
      @my_network_id = '4d5dc61ed0c0b32b79000001'

      # Set FakeWeb to allow a real connection to the Badgeville server as
      # configured in spec_helper.rb
      FakeWeb.allow_net_connect = true

      # Configure the gem
      Config.conf(:host_name => 'http://staging.badgeville.com', :api_key => '007857cd4fb9f360e120589c34fea080')

      # Basic README: Create a new site
      @new_site = Site.new(
        :name       => "My Website #{@rand1}",
        :url        => "mydomain#{@rand1}.com" ,
        :network_id => @my_network_id )
      @site_created = @new_site.save

      # # Basic README: Create a new user
      @new_user = User.new(
        :name       => "visitor#{@rand1}",
        :network_id => @my_network_id,
        :email      => "visitor#{@rand1}@emailserver.com",
        :password   => 'visitor_password' )
      @user_created = @new_user.save

      # Basic README: Find the newly created user to update their email address
      @user_found_by_id       = BadgevilleBerlin::User.find( @new_user.id )
      @user_found_by_id.email = "visitor#{@rand2}@emailserver.com"
      @user_updated           = @user_found_by_id.save

      # Basic README: Create a player
      @new_player = Player.new(
        :site_id      => @new_site.id,
        :user_id      => @new_user.id ,
        :display_name => "Visitor #{@rand1}" )
      @player_created = @new_player.save

      # Advanced README: Create an activity (register a behavior 'share') for the newly created player
      @share_activity = Activity.new(
        :verb      => "share#{@rand1}",
        :player_id => @new_player.id )
      @share_activity_created = @share_activity.save

      # Advanced README: Create an activity definition to specify that a player will earn 4
      # points each time they perform the "comment" behavior.
      @new_activity_definition = ActivityDefinition.new(
        :points => 4,
        :name => "A Cool Comment Behavior #{@rand1}",
        :site_id => @new_site.id,
        :verb => "comment#{@rand1}" )
      @new_activity_defn_created = @new_activity_definition.save


      # Advanced README: Update the activity definition such that a player
      # on your site will earn 3 points rather than 4 each time they
      # perform the "comment" behavior.
      @new_activity_definition.adjustment.points = 3
      @new_activity_defn_updated = @new_activity_definition.save

      #  # Advanced README: Update the activity definition to include a rate
      #  # limit in order to prevent players from gaming the system.
       @new_activity_definition.enable_rate_limiting = true
       @new_activity_definition.bucket_drain_rate = 180
       @new_activity_definition.bucket_max_capacity = 25
       @new_activity_defn_updated_again = @new_activity_definition.save

       # Advanced README: Register a player behavior (e.g. comment) for an
       # existing player.
       @comment_activity = Activity.new(
         :verb      => "comment#{@rand1}",
         :player_id => @new_player.id )
       @comment_activity_created = @comment_activity.save

       # Advanced README: Find the updated player to verify that points
       # were successfully attributed.
       @updated_player = Player.find(@new_player.id)
    end

    # CREATE Site
    it "should have created a new site", :affects_bv_server => true do
       @site_created.should == true
    end

    it "should have a new site with the name:  My Website #{@rand1}", :affects_bv_server => true do
      @new_site.name.should == "My Website #{@rand1}"
    end


    # CREATE User
    it "should have created a new user", :affects_bv_server => true do
        @user_created.should == true
    end

    it "should have a new user with the name: visitor#{@rand1}", :affects_bv_server => true do
      @new_user.name.should == "visitor#{@rand1}"
    end


    # UPDATE User
    it "should have updated the newly created user", :affects_bv_server => true do
      @user_updated.should == true
    end

    it "should have found the newly created user by ID to update their email address", :affects_bv_server => true do
      @user_found_by_id.email.should == "visitor#{@rand2}@emailserver.com"
    end


    # CREATE Player
    it "should have created a new player", :affects_bv_server => true do
        @player_created.should == true
    end

    it "should have a new player with user ID for @new_user", :affects_bv_server => true do
      @new_player.user_id.should == @new_user.id
    end


    # CREATE Activity (share)
    it "should have created a new share activity", :affects_bv_server => true do
      @share_activity_created.should == true
    end

    it "should have registered a new share#{@rand1} activity", :affects_bv_server => true do
      @share_activity.verb.should == "share#{@rand1}"
    end


    # CREATE ActivityDefinition
    it "should have created a new activity definition", :affects_bv_server => true do
      @new_activity_defn_created.should == true
    end

    it "should have a new activity definition for comment#{@rand1}", :affects_bv_server => true do
      @new_activity_definition.verb.should == "comment#{@rand1}"
    end


    # UPDATE ActivityDefinition (points)
    it "should have updated the activity definition a 1st time", :affects_bv_server => true do
      @new_activity_defn_updated.should == true
    end

    it "should have updated the activity definition points for comment#{@rand1}", :affects_bv_server => true do
      @new_activity_definition.adjustment.points.should == 3
    end


    # UPDATE ActivityDefinition (rate-limiting)
    it "should have updated the activity definition a 2nd time", :affects_bv_server => true do
      @new_activity_defn_updated.should == true
    end

    it "should have updated the activity definition to enable rate limiting", :affects_bv_server => true do
      @new_activity_definition.enable_rate_limiting.should == true
      @new_activity_definition.bucket_drain_rate.should    == 180
      @new_activity_definition.bucket_max_capacity.should  == 25
    end


    # CREATE Activity (comment)
    it "should have created a new comment activity", :affects_bv_server => true do
      @comment_activity_created.should == true
    end

    it "should have registered a new comment#{@rand1} activity", :affects_bv_server => true do
      @comment_activity.verb.should == "comment#{@rand1}"
    end

    it "should have added 3 points to @new_player", :affects_bv_server => true # do
    #       @updated_player.points_all.should == 3
    #     end
  end
end