require 'active_resource'

# Adds BadgevilleBerlinJson custom format.
require "badgeville-berlin/formats/badgeville_berlin_json_format.rb"

# Subclasses ActiveResource.
require "badgeville-berlin/base_resource.rb"
require "badgeville-berlin/config.rb"
require "badgeville-berlin/errors.rb"

# Subclasses for remote resources.
require "badgeville-berlin/activity.rb"
require "badgeville-berlin/activity_definition.rb"
require "badgeville-berlin/group.rb"
require "badgeville-berlin/leaderboard.rb"
require "badgeville-berlin/player.rb"
require "badgeville-berlin/reward.rb"
require "badgeville-berlin/reward_definition.rb"
require "badgeville-berlin/site.rb"
require "badgeville-berlin/track.rb"
require "badgeville-berlin/user.rb"

module BadgevilleBerlin
end