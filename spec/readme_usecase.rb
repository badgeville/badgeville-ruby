require 'spec_helper'

module BadgevilleBerlin
  describe "Basic README use case examples" do


    before(:all) do
      # Initializations
      @rand1 = rand(5000)
      @rand2 = rand(5000)
      @my_network_id = '4d5dc61ed0c0b32b79000001'

      # Set FakeWeb to allow a real connection to the Badgeville server as
      # configured in spec_helper.rb
      FakeWeb.allow_net_connect = true

      # Create a new site
      @new_site = BadgevilleBerlin::Site.new(
        :name       => "My Website #{@rand1}",
        :url        => "mydomain#{@rand1}.com" ,
        :network_id => @my_network_id )
      @site_created = @new_site.save

      # Create a new user
      @new_user = BadgevilleBerlin::User.new(
        :name       => "visitor#{@rand1}",
        :network_id => @my_network_id,
        :email      => "visitor#{@rand1}@emailserver.com",
        :password   => 'visitor_password' )
      @user_created = @new_user.save

      # Find the newly created user to update their email address
      @user_found_by_id       = BadgevilleBerlin::User.find( @new_user.id )
      @user_found_by_id.email = "visitor#{@rand2}@emailserver.com"
      @user_found = @user_found_by_id.save

      # Create a player
      @new_player = BadgevilleBerlin::Player.new(
        :site_id => @new_site.id,
        :user_id => @new_user.id )
      @player_created = @new_player.save

      # Create an activity (register a behavior 'share') for the newly created player
      @new_activity = BadgevilleBerlin::Activity.new(
        :verb      => 'share',
        :player_id => @new_player.id )
      @new_activity_created = @new_activity.save

      # Create an activity definition to specify that a player will earn 4
      # points each time they perform the "comment" behavior.
      # @new_activity_definition = ActivityDefinition.new(
      #   :adjustment => {:points => 4},
      #   :name => 'comment_earns_4points',
      #   :site_id => @new_site.id,
      #   :verb => 'comment' )
      # @new_activity_definition_created = @new_activity_definition.save


    end


    it "should have created a new site" do
      @site_created.should == true
    end

    it "should have created a user to add them the network" do
      @user_created.should == true
    end

    it "should have found the newly created user by ID to update their email address" do
      @user_found_by_id.email.should == "visitor#{@rand2}@emailserver.com"
    end

    it "should have created a new player" do
      @player_created.should == true
    end

    it "should have created a new activity" do
       @new_activity_created.should == true
    end

    it "should have created a new activity definition" do
       @new_activity_definition_created.should == true
    end

  end
end