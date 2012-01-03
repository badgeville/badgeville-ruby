require 'spec_helper'
require 'json'

describe Badgeville::API do
  ######################################
  # Activities
  ######################################

  describe 'activities' do
    it 'should allow you to create an activity using site and player e-mail' do
      VCR.use_cassette('activities/create_activity') do
        badgeville_response = @badgeville.create_activity(
          :site => 'community.stagingdomain.com',
          :user => '098@staging-badgeville-somedomain.com',
          :activity => {:verb => 'api_test_v2'}
        )
        badgeville_response.code.should eql(201)
      end
    end

    it 'should allow you to create an activity using player_id' do
      VCR.use_cassette('activities/create_activity_using_player_id') do
        badgeville_response = @badgeville.create_activity(
          :player_id => '4ee7bc0c3dc64810b0000157',
          :activity => {:verb => 'api_test_v2'}
        )
        badgeville_response.code.should eql(201)
      end
    end

    it 'should be able to list activities' do
      VCR.use_cassette('activities/list_activities') do
        badgeville_response = @badgeville.list_activities(:site => 'community.stagingdomain.com')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end
  end

  ######################################
  # Activity Definitions
  ######################################

  describe 'activity definitions' do
    it 'should be able to create an activity definition' do
      VCR.use_cassette('activity_definitions/create_activity_definition') do
        badgeville_response = @badgeville.create_activity_definition(
          :activity_definition => {
            :site_id => '4d700bd351c21c1e3c000004',
            :name => 'API test (V2) activity - gem test',
            :selector => '{"verb":"api_test_v2_gem"}',
            :adjustment => '{"points":5}'
          }
        )
        badgeville_response.code.should eql(201)
      end
    end

    it 'should be able to list activity definitions' do
      VCR.use_cassette('activity_definitions/list_activity_definitions') do
        badgeville_response = @badgeville.list_activity_definitions(:site => 'community.stagingdomain.com')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end

    it 'should be able to get an activity definition' do
      VCR.use_cassette('activity_definitions/get_activity_definition_by_id') do
        badgeville_response = @badgeville.get_activity_definition('4e95d3ed6a898d3aa3011581')
        badgeville_response.code.should eql(200)
      end
    end

    it 'should be able to update an activity definition' do
      VCR.use_cassette('activity_definitions/update_activity_definition') do
        badgeville_response = @badgeville.update_activity_definition('4dcc44e4c47eed597300c22a', {:name => 'A new updated name}'})
        badgeville_response.code.should eql(200)
      end
    end

    it 'should be able to delete an activity definition' do
      VCR.use_cassette('activity_definitions/delete_activity') do
        badgeville_response = @badgeville.delete_activity_definition('4dcc4637c47eed597000bfe6')
        badgeville_response.code.should eql(200)
      end
    end
  end

  ######################################
  # Reward Definitions
  ######################################

  describe 'reward definitions' do
    it 'should be able to create a reward definition' do
      VCR.use_cassette('reward_definitions/create_reward_definition') do
        badgeville_response = @badgeville.create_reward_definition(
          :reward_definition => {
            :site_id => '4d700bd351c21c1e3c000004',
            :name => 'API test (V2) reward - gem test',
            :components => '[{"comparator":{"$gte":1},"command":"count","where":{"verb":"api_test_v2","user_id":"%user_id","site_id":"%site_id"}}]',
            :reward_template => '{"message":"Congratulations! You\'ve won the API test V2 badge!"}',
            :tags => 'API,test,v2',
            :active => true
          }
        )
        badgeville_response.code.should eql(201)
      end
    end
  end

  ######################################
  # Users
  ######################################

  describe 'users' do
    it 'should allow you to create a user' do
      VCR.use_cassette('users/create_user') do
        badgeville_response = @badgeville.create_user('a_badgeville_user', 'a_badgeville_user@email.com')
        badgeville_response.code.should eql(201)
      end
    end

    it 'should allow you to get a user by email' do
      VCR.use_cassette('users/list_user_by_email') do
        badgeville_response = @badgeville.get_user('a_badgeville_user@email.com')
        badgeville_response.code.should eql(200)
      end
    end

    it 'should allow you to get a user by ID' do
      VCR.use_cassette('users/list_user_by_ID') do
        badgeville_response = @badgeville.get_user('4ee68ff06a898d10f8000104')
        badgeville_response.code.should eql(200)
      end
    end

    it 'should allow you to list the users' do
      VCR.use_cassette('users/list_users') do
        badgeville_response = @badgeville.list_users(:page => 1, :per_page => 10)
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end

    it 'should allow you to update a user by ID' do
      VCR.use_cassette('users/update_user_by_ID') do
        badgeville_response = @badgeville.update_user('4e9604a14d6ce65520020998', 'a_new_name', '098@staging-badgeville-somedomain.com')
        badgeville_response.code.should eql(200)
      end
    end


    it 'should allow you to delete a user by email' do
      VCR.use_cassette('users/delete_user_by_email') do
        badgeville_response = @badgeville.delete_user('a_badgeville_user@email.com')
        badgeville_response.code.should eql(0)
      end
    end

    it 'should allow you to delete a user by ID' do
      VCR.use_cassette('users/delete_user_by_ID') do
        badgeville_response = @badgeville.delete_user('4ee68ff06a898d10f8000104')
        badgeville_response.code.should eql(0)
      end
    end
  end

  ######################################
  # Players
  ######################################

  describe 'players' do
    it 'should allow you to create a player' do
      VCR.use_cassette('players/create_player') do
        badgeville_response = @badgeville.create_user('player_hater', 'player_hater@community.stagingdomain.com')
        badgeville_response.code.should eql(201)

        badgeville_response = @badgeville.create_player(:email => 'player_hater@community.stagingdomain.com', 
          :site => 'community.stagingdomain.com', :player => {:email => 'player_hater@community.stagingdomain.com'},
          :verbose => true)
        badgeville_response.code.should eql(201)
      end
    end

    it 'should allow you to list the players' do
      VCR.use_cassette('players/list_players') do
        badgeville_response = @badgeville.list_players(:page => 1, :per_page => 15)
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(15)
      end
    end

    it 'should allow you to list the players and filter by email' do
      VCR.use_cassette('players/list_players_and_filter_by_email') do
        badgeville_response = @badgeville.list_players(:email => '117@staging-badgeville-somedomain.com')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(1)
      end
    end

    it 'should allow you to get a player' do
      VCR.use_cassette('players/get_player') do
        badgeville_response = @badgeville.get_player('4dcd8c3ac47eed6b2a000077')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data']['id'].should eql('4dcd8c3ac47eed6b2a000077')
      end
    end

    it 'should allow you to update a player' do
      VCR.use_cassette('players/update_player') do
        badgeville_response = @badgeville.update_player('4dd12aa0c47eed6b2a0007ed', 
          :player => {:first_name => 'UpdatedFirstName'})
        badgeville_response.code.should eql(200)
      end
    end

    it 'should allow you to delete a player' do
      VCR.use_cassette('players/delete_player') do
        badgeville_response = @badgeville.delete_player('4de5090dc47eed17720004b5')
        badgeville_response.code.should eql(200)
      end
    end
  end

  ######################################
  # Rewards
  ######################################  

  describe 'rewards' do
    it 'should allow you to create a reward' do
      VCR.use_cassette('rewards/create_reward') do
        badgeville_response = @badgeville.create_reward(
          :reward => {
            :site_id => '4d9f67f951c21c5100000013',
            :player_id => '4de5090dc47eed17720004b5',
            :definition_id => '4e691a01c47eed282900000e' 
          }
        )
        badgeville_response.code.should eql(201)
      end
    end

    it 'should allow you to get a reward' do
      VCR.use_cassette('rewards/get_reward') do
        badgeville_response = @badgeville.get_reward('4e691cf9c47eed2809000094')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data']['name'].should eql('Season Champion in a Battlefield: Bad Company 2 Team Ladder')
      end
    end

    it 'should allow you to list rewards' do
      VCR.use_cassette('rewards/list_rewards') do
        badgeville_response = @badgeville.list_rewards
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end

    it 'should allow you to list rewards and filter with options' do
      VCR.use_cassette('rewards/list_rewards_with_options_filter') do
        badgeville_response = @badgeville.list_rewards(:tags => 'battlefield-bad-company-2,ps3')
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end

    it 'should allow you to delete a reward' do
      VCR.use_cassette('rewards/delete_reward') do
        badgeville_response = @badgeville.delete_reward('4e691cf9c47eed2809000094')
        badgeville_response.code.should eql(200)
      end
    end
  end

  ######################################
  # Sites
  ######################################  

  describe 'sites' do
    it 'should allow you to list sites' do
      VCR.use_cassette('sites/list_sites') do
        badgeville_response = @badgeville.list_sites
        badgeville_response.code.should eql(200)
        parsed_badgeville_response = JSON.parse(badgeville_response.body)
        parsed_badgeville_response['data'].size.should eql(10)
      end
    end
  end
end