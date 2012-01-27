# Badgeville RESTful Wrapper for Berlin API -- Advanced README

This is a Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Features
* Uses the activeresource (3.1.3) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Allows creating, reading (finding), updating and deleting the following classes of remote resources: Site, User, Player, ActivityDefinition, Activity.

##Advanced Examples

### 0. Please see Basic Examples in the [Basic README](https://github.com/badgeville/badgeville-ruby/blob/alpha/README.markdown) first.

### 1. Configure the gem to use your Badgeville API Key and the site to which your requests should go.
```ruby
BadgevilleBerlin::Config.conf(
  :host_name => "http://example.com",
  :api_key   => MY_API_KEY)
```

### 2. Create an activity definition. [(more on activity definition)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-CreatingAdvancedBehaviors)
<ul>
  <li>Create an activity definition to store additional information you want to use in rewards determination.</li>
  <li>Here we create an activity definition to specify that a player will earn 4 points each time they perform the "comment" behavior.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for required and optional parameters.</li>
</ul>
```ruby
new_activity_definition = ActivityDefinition.new(
  :adjustment => '{"points": 5}',
  :name => 'A Cool Comment Behavior',
  :site_id => new_site.id,
  :selector => '{"verb":"vote"}' )
success = new_activity_definition.save
```

### 3. Update the properties of activity definition: points. [(more on points)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-CreatingSimpleBehaviors)
<ul>
  <li>Here we update the activity definition so that a player on our site will earn 3 points rather than 4 each time they perform the "comment" behavior.
  </li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for a full list of activity definition properties to update.</li>
</ul>
```ruby
new_activity_definition.adjustment.points = 3
success = new_activity_definition.save
```

### 4. Update the properties of activity definition: enable rate-limiting. [(more on rate-limiting)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-BehaviorRateLimits)
<ul>
  <li>Here we update the activity definition to make it rate-limiting to prevent players from gaming the system.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for a full list of activity definition properties to update.</li>
</ul>
```ruby
new_activity_definition.enable_rate_limiting   = true
  new_activity_definition.bucket_drain_rate    = 180
  new_activity_definition.bucket_max_capacity  = 25
  new_activity_definition.save
```

### 5. Register a player behavior.
<ul>
  <li>Here we record the fact that the newly created player performed a "comment" behavior.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for required and optional parameters.</li>
</ul>
```ruby
new_activity = BadgevilleBerlin::Activity.new(
  :verb      => 'comment',
  :player_id => new_player.id )
success = new_activity.save
```

### 6. Find the player properties after registering a behavior.
<ul>
  <li>Here we record the fact that the newly created player performed a "comment" behavior.</li>
  <li>Print out the BadgevilleBerlin::Player object (i.e. updated_player) to get a full list of player properties.</li>
</ul>
```ruby
  updated_player = BadgevilleBerlin::Player.find(new_player.id)
  updated_player.points_all
```


## Dependencies, Installation & Documentation
Please see the [Basic README](https://github.com/badgeville/badgeville-ruby/blob/alpha/README.markdown) for details.

## Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation is available here.

##Feedback
Please email your comments to <supraja@badgeville.com>.

Copyright (c) 2012 Badgeville.