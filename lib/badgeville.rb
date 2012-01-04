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
      post_to_badgeville('activities', options)
    end

    def list_activities(options = {})
      get_list_from_badgeville('activities', options)
    end

    ######################################
    # Activity Definitions
    ######################################

    def create_activity_definition(options = {})
      post_to_badgeville('activity_definitions', options)
    end

    def get_activity_definition(activity_definition_id)
      get_from_badgeville('activity_definitions', activity_definition_id)
    end

    def list_activity_definitions(options = {})
      get_list_from_badgeville('activity_definitions', options)
    end

    def update_activity_definition(activity_definition_id, options)
      put_to_badgeville('activity_definitions', activity_definition_id, options)
    end

    def delete_activity_definition(activity_definition_id)
      delete_from_badgeville('activity_definitions', activity_definition_id)
    end

    ######################################
    # Groups
    ######################################

    def create_group(options = {})
      post_to_badgeville('groups', options)
    end

    def get_group(group_id)
      get_from_badgeville('groups', group_id)
    end

    def list_groups(options = {})
      get_list_from_badgeville('groups', options)
    end

    def update_group(group_id, options = {})
      put_to_badgeville('groups', group_id, options)
    end

    def delete_group(group_id)
      delete_from_badgeville('groups', group_id)
    end

    ######################################
    # Leaderboards
    ######################################

    def create_leaderboard(options = {})
      post_to_badgeville('leaderboards', options)
    end

    def list_leaderboards(options = {})
      get_list_from_badgeville('leaderboards', options)
    end

    def get_leaderboard(leaderboard_id)
      get_from_badgeville('leaderboards', leaderboard_id)
    end

    def update_leaderboard(leaderboard_id, options = {})
      put_to_badgeville('leaderboards', leaderboard_id, options)
    end

    def delete_leaderboard(leaderboard_id)
      delete_from_badgeville('leaderboards', leaderboard_id)
    end

    ######################################
    # Players
    ######################################

    def create_player(options = {})
      post_to_badgeville('players', options)
    end

    def info_player(site, email)
      response = Typhoeus::Request.get(build_api_url("players/info.json"),
        :params => {:site => site, :email => email}, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def list_players(options = {})
      get_list_from_badgeville('players', options)
    end

    def get_player(player_id)
      get_from_badgeville('players', player_id)
    end

    def update_player(player_id, options = {})
      put_to_badgeville('players', player_id, options)
    end

    def delete_player(player_id)
      delete_from_badgeville('players', player_id)
    end

    ######################################
    # Rewards
    ######################################

    def create_reward(options = {})
      post_to_badgeville('rewards', options)
    end

    def get_reward(reward_id)
      get_from_badgeville('rewards', reward_id)
    end

    def list_rewards(options = {})
      get_list_from_badgeville('rewards', options)
    end

    def delete_reward(reward_id)
      delete_from_badgeville('rewards', reward_id)
    end

    ######################################
    # Reward Definitions
    ######################################

    def create_reward_definition(options = {})
      post_to_badgeville('reward_definitions', options)
    end

    def get_reward_definition(reward_definition_id)
      get_from_badgeville('reward_definitions', reward_definition_id)
    end

    def list_reward_definitions(options = {})
      get_list_from_badgeville('reward_definitions', options)
    end

    def update_reward_definition(reward_definition_id, options = {})
      put_to_badgeville('reward_definitions', reward_definition_id, options)
    end

    def delete_reward_definition(reward_definition_id)
      delete_from_badgeville('reward_definitions', reward_definition_id)
    end

    ######################################
    # Sites
    ######################################

    def create_site(options = {})
      post_to_badgeville('sites', options)
    end

    def get_site(site_id_or_url)
      get_from_badgeville('sites', site_id_or_url)
    end

    def list_sites(options = {})
      get_list_from_badgeville('sites', options)
    end

    def update_site(site_id_or_url, options = {})
      put_to_badgeville('sites', site_id_or_url, options)
    end

    def delete_site(site_id_or_url)
      delete_from_badgeville('sites', site_id_or_url)
    end

    ######################################
    # Tracks
    ######################################

    def create_track(options = {})
      post_to_badgeville('tracks', options)
    end

    def get_track(track_id)
      get_from_badgeville('tracks', track_id)
    end

    def list_tracks(options = {})
      get_list_from_badgeville('tracks', options)      
    end

    def update_track(track_id, options = {})
      put_to_badgeville('tracks', track_id, options)
    end

    def delete_track(track_id)
      delete_from_badgeville('tracks', track_id)
    end

    ######################################
    # Users
    ######################################

    def create_user(options = {})
      post_to_badgeville('users', options)
    end

    def get_user(email_or_id)
      get_from_badgeville('users', email_or_id)
    end

    def list_users(options = {})
      get_list_from_badgeville('users', options)
    end

    def update_user(email_or_id, options = {})
      put_to_badgeville('users', email_or_id, options)
    end

    def delete_user(email_or_id)
      delete_from_badgeville('users', email_or_id)
    end

    private

    def get_from_badgeville(endpoint, id)
      response = Typhoeus::Request.get(build_api_url("#{endpoint}/#{id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def get_list_from_badgeville(endpoint, options = {})
      response = Typhoeus::Request.get(build_api_url("#{endpoint}.json"), 
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def post_to_badgeville(endpoint, options = {})
      response = Typhoeus::Request.post(build_api_url("#{endpoint}.json"), :params => options,
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def put_to_badgeville(endpoint, id, options = {})
      response = Typhoeus::Request.put(build_api_url("#{endpoint}/#{id}.json"),
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_from_badgeville(endpoint, id)
      response = Typhoeus::Request.delete(build_api_url("#{endpoint}/#{id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end
    
    def build_api_url(api_method)
      "#{@api_url}/#{@token}/#{api_method}"
    end  
  end
end
