# Badgeville RESTful Wrapper for Berlin API -- Advanced README

This is a Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Features
* Uses the activeresource (3.0.5) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Allows creating, reading (finding), updating and deleting the following classes of remote resources: Site, User, Player, ActivityDefinition, Activity.

##Advanced Examples

### 0. Please check out the [Basic Examples](https://github.com/badgeville/badgeville-ruby/blob/alpha/README.markdown) first.

### 1. Configure the gem to use your Badgeville API Key and the site to which your requests should go.
```ruby
BadgevilleBerlin::Config.conf(
  :site    => "http://sandbox.v2.badgeville.com",
  :api_key => MY_API_KEY)
```

### 2. Create an activity definition to specify that a player will earn 4 points each time they perform the "comment" behavior.
```ruby
new_activity_definition = ActivityDefinition.new(
  :adjustment => {:points => 4},
  :name => 'comment_earns_4points',
  :site_id => new_site.id,
  :verb => 'comment' )
success = new_activity_definition.save
```

### 3. Update the activity definition such that a player on your site will earn 3 points rather than 4 each time they perform the "comment" behavior.

```ruby
new_activity_definition.adjustment.points = 3
success = new_activity_definition.save
```

### 4. Update the activity definition to include a rate limit in order to prevent players from gaming the system. [(more)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-BehaviorRateLimits)
### Set bucket_rate_limit to 180 (20 comments per hour). Why?
### 180 (3600 (number of seconds in an hour) / 20 comments = 180 s. This will drain 1 comment every 3 minutes.
### Set bucket_max_capacity to 25.
### Why? This allows the player to create 25 comments as fast as they like, after which the bucket will begin to drain.
```ruby
new_activity_definition.enable_rate_limiting   = true
  new_activity_definition.bucket_drain_rate    = 180
  new_activity_definition.bucket_max_capacity  = 25
  new_activity_definition.save
```

### 6. Register a player behavior (e.g. comment) for an existing player "new_player."
```ruby
new_activity = BadgevilleBerlin::Activity.new(
  :verb      => 'share',
  :player_id => new_player.id )
success = new_activity.save
```

### 7. Find the number of points the player has earned after making the comment.
```ruby
  # [STILL NEEDS TO BE WRITTEN]
  new_player.
```

## Tips
### Monitoring HTTP Requests and JSON Responses
Print HTTP requests and JSON responses by installing the "logger" gem and including this code in your script.

```ruby
require 'logger'
BadgevilleBerlin::BaseResource.logger       = Logger.new(STDOUT)
BadgevilleBerlin::BaseResource.logger.level = Logger::DEBUG

```

### Avoiding "BadgevilleBerlin::"
Encapsulate your code inside a module Badgeville to avoid frequently typing "Badgeville::"

```ruby
module BadgevilleBerlin
  # your code goes here
end
```

##Dependencies
* activeresource (3.1.3) - Provides Ruby classes to RESTfully interact with remote resources.
* logger (1.2.8) - Provides logging to the standard output stream.

## Installation
[STILL NEEDS TO BE WRITTEN]

## Documentation

For more documentation on how the Badgeville RESTful Berlin API works, see [here] (http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).

##Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation is available here.

##Feedback
Please email your comments to supraja@badgeville.com

Copyright (c) 2012 Badgeville.