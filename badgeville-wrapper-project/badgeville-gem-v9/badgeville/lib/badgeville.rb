require 'active_resource'

# ADDING BadgevilleJson custom format
require "badgeville/formats/badgeville_json_format.rb"

# SUBCLASSING ActiveResource
require "badgeville/base_resource.rb"
require "badgeville/config.rb"
require "badgeville/errors.rb"

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
end