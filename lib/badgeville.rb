require 'badgeville/version'
require 'typhoeus'

module Badgeville
  class API
    BADGEVILLE_API_URL = 'http://sandbox.v2.badgeville.com/api/berlin'
    DEFAULT_HEADERS = {
      'User-Agent' => "badgeville gem #{Badgeville::VERSION}",
      'Accept' => 'application/json'
    }
    DEFAULT_TIMEOUT = 5000
    DEFAULT_PAGING_OPTIONS = {
      :page => 1,
      :per_page => 10,
      :include_totals => true
    }

    attr_accessor :token
    attr_accessor :api_url
    attr_accessor :timeout

    def initialize(token, api_url = BADGEVILLE_API_URL)
      @token = token
      @api_url = api_url
      @timeout = DEFAULT_TIMEOUT
    end

    ######################################
    # Activities
    #
    # NOTE: Only create_ and list_ are 
    # defined in the Badgeville API 
    # documentation
    ######################################

    def create_activity(options = {})
      response = Typhoeus::Request.post(build_api_url('activities.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_activities(options = {})
      response = Typhoeus::Request.get(build_api_url('activities.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Activity Definitions
    ######################################

    def create_activity_definition(options = {})
      response = Typhoeus::Request.post(build_api_url('activity_definitions.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_activity_definition(activity_definition_id)
      response = Typhoeus::Request.get(build_api_url("activity_definitions/#{activity_definition_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_activity_definitions(options = {})
      response = Typhoeus::Request.get(build_api_url('activity_definitions.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_activity_definition(activity_definition_id, options)
      response = Typhoeus::Request.put(build_api_url("activity_definitions/#{activity_definition_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_activity_definition(activity_definition_id)
      response = Typhoeus::Request.delete(build_api_url("activity_definitions/#{activity_definition_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Reward Definitions
    ######################################

    def create_reward_definition(options = {})
      response = Typhoeus::Request.post(build_api_url('reward_definitions.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_reward_definition(reward_definition_id)
      response = Typhoeus::Request.get(build_api_url("reward_definitions/#{reward_definition_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_reward_definitions(options = {})
      response = Typhoeus::Request.get(build_api_url('reward_definitions.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_reward_definition(reward_definition_id, options = {})
      response = Typhoeus::Request.put(build_api_url("reward_definitions/#{reward_definition_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_reward_definition(reward_definition_id)
      response = Typhoeus::Request.delete(build_api_url("reward_definitions/#{reward_definition_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Users
    ######################################

    def create_user(options = {})
      response = Typhoeus::Request.post(build_api_url('users.json'), :params => options,
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_user(email_or_id)
      response = Typhoeus::Request.get(build_api_url("users/#{email_or_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_users(options = {})
      response = Typhoeus::Request.get(build_api_url('users.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_user(email_or_id, options = {})
      response = Typhoeus::Request.put(build_api_url("users/#{email_or_id}.json"),
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_user(email_or_id)
      response = Typhoeus::Request.delete(build_api_url("users/#{email_or_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Groups
    ######################################

    def create_group(options = {})
      response = Typhoeus::Request.post(build_api_url('groups.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_group(group_id, options = {})
      response = Typhoeus::Request.get(build_api_url("groups/#{group_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_groups(options = {})
      response = Typhoeus::Request.get(build_api_url('groups.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_group(group_id, options = {})
      response = Typhoeus::Request.put(build_api_url("groups/#{group_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_group(group_id)
      response = Typhoeus::Request.delete(build_api_url("groups/#{group_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Players
    ######################################

    def create_player(options = {})
      response = Typhoeus::Request.post(build_api_url('players.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def info_player(site, email)
      response = Typhoeus::Request.get(build_api_url("players/info.json"),
        :params => {:site => site, :email => email}, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_players(options = {})
      response = Typhoeus::Request.get(build_api_url('players.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_player(player_id)
      response = Typhoeus::Request.get(build_api_url("players/#{player_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_player(player_id, options = {})
      response = Typhoeus::Request.put(build_api_url("players/#{player_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_player(player_id)
      response = Typhoeus::Request.delete(build_api_url("players/#{player_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Leaderboards
    ######################################

    def create_leaderboard(options = {})
      response = Typhoeus::Request.post(build_api_url('leaderboards.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_leaderboards(options = {})
      response = Typhoeus::Request.get(build_api_url('leaderboards.json'), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_leaderboard(leaderboard_id)
      response = Typhoeus::Request.get(build_api_url("leaderboards/#{leaderboard_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_leaderboard(leaderboard_id, options = {})
      response = Typhoeus::Request.put(build_api_url("leaderboards/#{leaderboard_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_leaderboard(leaderboard_id)
      response = Typhoeus::Request.delete(build_api_url("leaderboards/#{leaderboard_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Rewards
    ######################################

    def create_reward(options = {})
      response = Typhoeus::Request.post(build_api_url('rewards.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_reward(reward_id)
      response = Typhoeus::Request.get(build_api_url("rewards/#{reward_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_rewards(options = {})
      response = Typhoeus::Request.get(build_api_url('rewards.json'),
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_reward(reward_id)
      response = Typhoeus::Request.delete(build_api_url("rewards/#{reward_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Sites
    ######################################

    def create_site(options = {})
      response = Typhoeus::Request.post(build_api_url('sites.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_site(site_id_or_url)
      response = Typhoeus::Request.get(build_api_url("sites/#{site_id_or_url}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_sites(options = {})
      response = Typhoeus::Request.get(build_api_url('sites.json'),
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def update_site(site_id_or_url, options = {})
      response = Typhoeus::Request.put(build_api_url("sites/#{site_id_or_url}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_site(site_id_or_url)
      response = Typhoeus::Request.delete(build_api_url("sites/#{site_id_or_url}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    private
    
    def build_api_url(api_method)
      "#{@api_url}/#{@token}/#{api_method}"
    end  
  end
end
