require 'active_resource'

# ADDING BadgevilleJson custom format
require "badgeville/formats/badgeville_json_format.rb"

# SUBCLASSING ActiveResource
require "badgeville/base_resource.rb"

# SUBCLASSING for remote resources
require "badgeville/activity.rb"
require "badgeville/activity_definition.rb"
require "badgeville/group.rb"
require "badgeville/leaderboard.rb"
require "badgeville/player.rb"
require "badgeville/reward.rb"
require "badgeville/reward_definition.rb"
require "badgeville/site.rb"
require "badgeville/track.rb"
require "badgeville/user.rb"

# ADDING logger to print out HTTP requests and responses
require "badgeville/logger.rb"




module Badgeville

  class Config < BaseResource
    class << self

      # This class method configures the BaseResource members: format,
      # site and prefix
      #
      # @param [Hash] options the options hash which holds values for the keys `:api_key` and `:site`
      def conf ( options = {} )
        BaseResource.format = :badgeville_json
        BaseResource.site = options[:site]    if options[:site]
        @api_key = options[:api_key]          if options[:api_key]

        # set a path that goes between the URL and the resource
        BaseResource.prefix = "/api/berlin/#@api_key/"
      end

    end
  end

  # Subclasses ActiveResource::Errors to be used by BaseResource as Badgeville::Errors.
  class Errors < ActiveResource::Errors
    # Grabs errors originating from the remote model class. The custom JSON error
    # response format may not have a root key :errors.
    #
    # @param [ActiveSupport::JSON] json the JSON response data in custom BadgevilleJsonFormat
    # @return [Array] error messages associated with the remote model
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

  end
end