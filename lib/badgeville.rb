require 'active_resource'

# Adds BadgevilleJson custom format.
require "badgeville/formats/badgeville_json_format.rb"

# Subclasses ActiveResource.
require "badgeville/base_resource.rb"
require "badgeville/config.rb"
require "badgeville/errors.rb"

# Subclasses for remote resources.
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

# Adds logger to print out HTTP requests and responses.
require "badgeville/logger.rb"

module Badgeville
end