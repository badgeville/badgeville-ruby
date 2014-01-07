require 'active_resource'

# Adds BadgevilleBerlinJson custom format.
require "badgeville_berlin/formats/badgeville_berlin_json_format.rb"

# Subclasses ActiveResource.
require "badgeville_berlin/base_resource.rb"
require "badgeville_berlin/config.rb"
require "badgeville_berlin/errors.rb"

# Subclasses for remote resources.
require "badgeville_berlin/activity.rb"
require "badgeville_berlin/activity_definition.rb"
require "badgeville_berlin/group.rb"
require "badgeville_berlin/leaderboard.rb"
require "badgeville_berlin/player.rb"
require "badgeville_berlin/reward.rb"
require "badgeville_berlin/reward_definition.rb"
require "badgeville_berlin/site.rb"
require "badgeville_berlin/team.rb"
require "badgeville_berlin/track.rb"
require "badgeville_berlin/user.rb"

module BadgevilleBerlin
end