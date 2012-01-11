require 'rubygems'
require 'active_resource'

# ADDING BadgevilleJson custom format
require_relative "badgeville/formats/badgeville_json_format.rb"

# SUBCLASSING ActiveResource
require_relative "badgeville/base_resource.rb"

# SUBCLASSING for remote resources
require_relative "badgeville/activity.rb"
require_relative "badgeville/activity_definition.rb"
require_relative "badgeville/group.rb"
require_relative "badgeville/leaderboard.rb"
require_relative "badgeville/player.rb"
require_relative "badgeville/reward.rb"
require_relative "badgeville/reward_definition.rb"
require_relative "badgeville/site.rb"
require_relative "badgeville/track.rb"
require_relative "badgeville/user.rb"

# ADDING logger to print out HTTP requests and responses
require_relative "badgeville/logger.rb"




module Badgeville
  module Config
    # ADDING class method to configure BaseResource
    # def setup ( target_site, apikey )
    #   self.site = target_site
    #   self.format = :badgeville_json
    #   # set a path that goes between the URL and the resource
    #   self.prefix = "/api/berlin/#{apikey}/"
    #   #self.apikey = '007857cd4fb9f360e120589c34fea080'
    # end
  end

  # SUBCLASSING ActiveResource::Errors to be used by BaseResource as Badgeville::Errors
  class Errors < ActiveResource::Errors
    # Grabs errors from a custom Badgeville-style json response that does
    # not have a root key :errors.
    def from_badgeville_json(json, save_cache = false)
      #puts "Here is the custom response ", ActiveSupport::JSON.decode(json)
      formatted_json_decoded = Array.new
      json_decoded = (ActiveSupport::JSON.decode(json)) rescue []
      json_decoded.each do |attribute_name, err_msgs|
        if err_msgs.is_a? Array
          err_msgs.each do |err_msg|
            formatted_json_decoded.push(attribute_name.humanize + " #{err_msg}")
          end
        elsif err_msgs.is_a? String
            formatted_json_decoded.push(attribute_name, err_msgs)
        end
      end
      from_array formatted_json_decoded, save_cache
    end

    # Grabs errors from a json response.
    def from_json(json, save_cache = false)
      array = Array.wrap(ActiveSupport::JSON.decode(json)['errors']) rescue []
      from_array array, save_cache
    end

  end
end