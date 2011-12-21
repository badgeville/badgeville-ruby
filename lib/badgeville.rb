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

    ######################################
    # Reward Definitions
    ######################################

    def create_reward_definition(options = {})
      response = Typhoeus::Request.post(build_api_url('reward_definitions.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Users
    ######################################

    def create_user(name, email)
      response = Typhoeus::Request.post(build_api_url('users.json'), :params => {
        :user => {
          :name => name,
          :email => email
        }
      }, :headers => DEFAULT_HEADERS, :timeout => @timeout)
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

    def update_user(email_or_id, name, email)
      response = Typhoeus::Request.put(build_api_url("users/#{email_or_id}.json"),
        :params => {
          :user => {
            :name => name,
            :email => email
          }
        }, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_user(email_or_id)
      response = Typhoeus::Request.delete(build_api_url("users/#{email_or_id}.json"), 
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    ######################################
    # Players
    ######################################

    def create_player(options)
      response = Typhoeus::Request.post(build_api_url('players.json'), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
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

    def update_player(player_id, options)
      response = Typhoeus::Request.put(build_api_url("players/#{player_id}.json"), 
        :params => options, :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    def delete_player(player_id)
      response = Typhoeus::Request.delete(build_api_url("players/#{player_id}.json"), 
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

    def list_sites(options = {})
      response = Typhoeus::Request.get(build_api_url('sites.json'),
        :params => DEFAULT_PAGING_OPTIONS.dup.merge!(options),
        :headers => DEFAULT_HEADERS, :timeout => @timeout)
    end

    private
    
    def build_api_url(api_method)
      "#{@api_url}/#{@token}/#{api_method}"
    end  
  end
end
