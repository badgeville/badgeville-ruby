require 'spec_helper'

module BadgevilleBerlin
  describe "README use case example set" do
    before(:all) do
      # Initializations
      @rand1 = rand(5000)
      @rand2 = rand(5000)
      @my_network_id = '<my_network_id>'

      # Set FakeWeb to allow a real connection to the Badgeville server as
      # configured in spec_helper.rb
      FakeWeb.allow_net_connect = true

      # Configure the gem with the host site and the API Key

      my_hostname = '<http://myhostname.com>'
      my_api_key = '<my_api_key>'

      Config.conf(:host_name => my_hostname, :api_key => my_api_key)

      # Basic README: Create a new site
      @new_site = Site.new(
        :name       => "My Website #{@rand1}",
        :url        => "mydomain#{@rand1}.com" ,
        :network_id => @my_network_id )
      @site_created = @new_site.save

      # Basic README: Create a new user
      @new_user = User.new(
        :name       => "visitor#{@rand1}",
        :network_id => @my_network_id,
        :email      => "visitor#{@rand1}@emailserver.com",
        :password   => 'visitor_password' )
      @user_created = @new_user.save

      # Basic README: See error messages from the remote server
      @new_user2 = User.new(
        :name       => "visitor#{@rand1}",
        :network_id => @my_network_id,
        :email      => "visitor#{@rand1}@emailserver.com",
        :password   => 'visitor_password' )
      @user_creation_failed = @new_user2.save
      @attr_specific_err = @new_user2.errors[:email]

      # Basic README: Create a player
      # Basic README: Find existing players that match the given email
      @new_player = Player.new(
        :site_id      => @new_site.id,
        :user_id      => @new_user.id ,
        :display_name => "Visitor #{@rand1}" )
      @player_created = @new_player.save

      # Advanced README: Create an activity (register a behavior 'share') for the newly created player
      @share_activity = Activity.new(
        :verb      => "share",
        :player_id => @new_player.id )
      @share_activity_created = @share_activity.save

      # Advanced README: Create an activity definition to specify that a player will earn 4
      # points each time they perform the "comment" behavior.
      @new_activity_definition = ActivityDefinition.new(
        :selector => {:verb => :comment},
        :name => "A Cool Comment Behavior #{@rand1}",
        :site_id => @new_site.id,
        :adjustment => {:points => 3}
        )
      @new_activity_defn_created = @new_activity_definition.save

      # Advanced README: Update the activity definition such that a player
      # on your site will earn 3 points rather than 4 each time they
      # perform the "comment" behavior.
      @new_activity_definition.adjustment = {:points => 3}
      @new_activity_defn_updated = @new_activity_definition.save

       # Advanced README: Update the activity definition to include a rate
       # limit in order to prevent players from gaming the system.
       @new_activity_definition.enable_rate_limiting = true
       @new_activity_definition.bucket_drain_rate = 180
       @new_activity_definition.bucket_max_capacity = 25
       @new_activity_defn_updated_again = @new_activity_definition.save

       # Advanced README: Create a reward definition
       @new_reward_defn = RewardDefinition.new(
        :site_id          => @new_site.id,
        :name             => 'Comment Rockstar',
        :reward_template  => '{"message":"Congrats, you are a Comment Rockstar!"}',
        :components       => '[{"comparator":{"$gte":1},"where":{"verb":"comment","player_id":"%player_id"},"command":"count"}]',
        :active           => true )
       @new_reward_defn_created = @new_reward_defn.save

       # Create a mission which includes this reward definition
       @new_group = Group.new(
          :site_id => @new_site.id,
          :name => 'Comment Rockstar Mission'
       )
       @new_group_created = @new_group.save

       # Advanced README: Register a player behavior (e.g. comment) for an
       # existing player.
       @comment_activity = Activity.new(
         :verb      => "comment",
         :player_id => @new_player.id )
       @comment_activity_created = @comment_activity.save

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

    # CREATE User: See remote errors
    it "should produce an error message from the remote server", :affects_bv_server => true do
      @new_user2.errors.messages.should == {:email=>["user email is already taken"]}
    end

    it "should produce anattribute-specific error message from the remote server", :affects_bv_server => true do
      @attr_specific_err.should == ["user email is already taken"]
    end

    # CREATE Player
    it "should have created a new player", :affects_bv_server => true do
      @player_created.should == true
    end

    it "should have a new player with user ID for @new_user", :affects_bv_server => true do
      @new_player.user_id.should == @new_user.id
    end

    # FIND Players by email (:all matches)
    it "should return all players that match the email address as a collection", :affects_bv_server => true do
      @existing_player = Player.find(:all, :params => {:email => "visitor#{@rand1}@emailserver.com"})
      @existing_player.first.email.should == "visitor#{@rand1}@emailserver.com"
    end

    # FIND Player by email (:first match)
    it "should return the first player that matches the email address as a single record", :affects_bv_server => true do
      @existing_player = Player.find(:first, :params => {:email => "visitor#{@rand1}@emailserver.com"})
      @existing_player.email.should == "visitor#{@rand1}@emailserver.com"
    end

    # FIND Player by email (:last match)
    it "should return the first player that matches the email address as a single record", :affects_bv_server => true do
      @existing_player = Player.find(:last, :params => {:email => "visitor#{@rand1}@emailserver.com"})
      @existing_player.email.should == "visitor#{@rand1}@emailserver.com"
    end

    # CREATE Activity (share)
    it "should have created a 1st activity", :affects_bv_server => true do
      @share_activity_created.should == true
    end

    it "should have registered a new share activity", :affects_bv_server => true do
      @share_activity.verb.should == "share"
    end

    # CREATE ActivityDefinition
    it "should have created a new activity definition", :affects_bv_server => true do
      @new_activity_defn_created.should == true
    end

    it "should have a new activity definition for comment", :affects_bv_server => true do
      @new_activity_definition.verb.should == "comment"
    end

    # CREATE Activity (comment)
    it "should have created a 2nd activity", :affects_bv_server => true do
      @comment_activity_created.should == true
    end

    it "should have registered a new comment activity", :affects_bv_server => true do
      @comment_activity.verb.should == "comment"
    end

    it "should have added 3 points to the new player", :affects_bv_server => true do
      @updated_player = Player.find(@new_player.id)
      @updated_player.points_all.should == 3
    end

    it "should have added 1 reward to the new player", :affects_bv_server => true do
      Reward.find(:all, :params => {:player_id => @new_player.id})[0].name.should == "Comment Rockstar"
    end

    # CREATE RewardDefinition
    it "should have created a new reward definition", :affects_bv_server => true do
      @new_reward_defn_created.should == true
    end

    it "should have a new reward definition with the name 'Comment Rockstar'", :affects_bv_server => true do
      @new_reward_defn.name.should == 'Comment Rockstar'
    end

    #UPDATE User
    it "should update the user", :affects_bv_server => true do
      # Basic README: Find the newly created user to update their email address
      @user_found_by_id       = User.find( @new_user.id )
      @user_found_by_id.email = "visitor#{@rand2}@emailserver.com"
      @user_updated           = @user_found_by_id.save

      User.find(@new_user.id).email.should == "visitor#{@rand2}@emailserver.com"
      @user_updated.should == true
    end

    # UPDATE ActivityDefinition (points)
    it "should have updated the activity definition a 1st time", :affects_bv_server => true do
      @new_activity_defn_updated.should == true
    end

    it "should have updated the activity definition points for comment", :affects_bv_server => true do
      @updated_activity_definition = ActivityDefinition.find(@new_activity_definition.id)
      @updated_activity_definition.adjustment.should == {"points" => { "definition" => 3}}
      @updated_activity_definition.selector.should == {"verb" => "comment"}
    end

    # UPDATE ActivityDefinition (rate-limiting)
    it "should have updated the activity definition a 2nd time", :affects_bv_server => true do
      @new_activity_defn_updated_again.should == true
    end

    it "should have updated the activity definition to enable rate limiting", :affects_bv_server => true do
      @new_activity_definition.enable_rate_limiting.should == true
      @new_activity_definition.bucket_drain_rate.should    == 180
      @new_activity_definition.bucket_max_capacity.should  == 25
    end

    # UPDATE Player
    it "should update the player with the display name \"Elite Player\"", :affects_bv_server => true do
      @new_player.display_name = "Elite Player"
      @new_player.save
      Player.find(@new_player.id).display_name.should == "Elite Player"
    end

    it "should update picture_url on the player object", :affects_bv_server => true  do
      @new_player.picture_url = "http://i.imgur.com/OsbzX.png"
      @new_player.save
      Player.find(@new_player.id).picture_url.should == "http://i.imgur.com/OsbzX.png"
    end

    # UPDATE RewardDefinition
    it "should update the reward definition with the name \"Comment Superstar\"", :affects_bv_server => true do
      @new_reward_defn.name = "Comment Superstar"
      @new_reward_defn.save
      RewardDefinition.find(@new_reward_defn.id).name.should == "Comment Superstar"
    end

    #UPDATE Site
    it "should update the site", :affects_bv_server => true do
      @new_site.name = "New Site Name #{rand(5000)}"
      @new_site.save
      Site.find(@new_site.id).name.should == @new_site.name
    end

    # DELETE RewardDefinition
    it "should have deleted a reward definition", :affects_bv_server => true do
      # Not in the README:
      @new_reward_defn2 = RewardDefinition.new(
        :site_id          => @new_site.id,
        :name             => 'Blog Rockstar',
        :reward_template  => '{"message":"Congrats, you are a Blog Rockstar!"}',
        :components       => '[{"comparator":{"$gte":1},"where":{"verb":"blog","player_id":"%player_id"},"command":"count"}]',
        :active           => true )
      @new_reward_defn2.save

      RewardDefinition.delete(@new_reward_defn2.id)
      lambda { RewardDefinition.find(@new_reward_defn2.id) }.should raise_error(ActiveResource::ResourceNotFound)
    end

    # DELETE ActivityDefinition
    it "should have deleted an activity definition", :affects_bv_server => true do
      ActivityDefinition.delete(@new_activity_definition.id)
      lambda { ActivityDefinition.find(@new_activity_definition.id) }.should raise_error(ActiveResource::ResourceNotFound)
    end

    # DELETE Player
    it "should have deleted a player", :affects_bv_server => true do
      Player.delete(@new_player.id)
      lambda { Player.find(@new_player.id) }.should raise_error(ActiveResource::ResourceNotFound)
    end

    # DELETE User
    it "should have deleted a user", :affects_bv_server => true do
      User.delete(@new_user.id)
      lambda { User.find(@new_user.id) }.should raise_error(ActiveResource::ResourceNotFound)
    end

    # DELETE Site
    it "should have deleted a site", :affects_bv_server => true do
      Site.delete(@new_site.id)
      lambda { Site.find(@new_site.id) }.should raise_error(ActiveResource::ResourceNotFound)
    end

    # FIND Group (a.k.a. Mission)
    # Not integration test!
    it "should parse correctly a group index call which includes rewards keyed under reward definitions", :affects_bv_server => true do
      BadgevilleBerlinJsonFormat.stub!(:decode).and_return([JSON.parse(BadgevilleBerlin.response_json["valid_group_all"])])
      response = Group.all
      #(params: {site: @new_site.url, per_page: 50, player_id: @new_player.id.to_s})
      response.first.rewards.count.should == 2
    end

  end
end