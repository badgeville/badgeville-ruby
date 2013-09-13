# Badgeville RESTful Wrapper for Berlin API -- Advanced README

This is an open source Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Features
* Uses the activeresource (3.1.3) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Allows creating, reading (finding), updating and deleting the following classes of remote resources: Site, User, Player, ActivityDefinition, Activity, Reward and RewardDefinition.

##Advanced Examples


### 0. Please see Basic Examples in the [Basic README](https://github.com/badgeville/badgeville-ruby/blob/alpha/README.markdown) first.


### 1. Configure the gem to use your Badgeville Private API Key and the site to which your requests should go.
```ruby
        BadgevilleBerlin::Config.conf(
          :host_name => "http://example.com",
          :api_key   => MY_API_KEY)
```

### 2. Create an activity definition. [(more on activity definition)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-CreatingAdvancedBehaviors)
<ul>
  <li>Create an activity definition to store additional information you want to use in rewards determination.</li>
  <li>Here we create an activity definition to specify that a player will earn 4 points each time they perform the "comment" behavior.</li>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>
```ruby
        new_activity_definition = ActivityDefinition.new(
          :adjustment => {:points => 4},
          :name => 'A Cool Comment Behavior',
          :site_id => new_site.id,
          :selector => {:verb => "comment"} )
        success = new_activity_definition.save
```

### 3. Update the properties of activity definition: points. [(more on points)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-CreatingSimpleBehaviors)
<ul>
  <li>Here we update the activity definition so that a player on our site will earn 3 points rather than 4 each time they perform the "comment" behavior.
  </li>
  <li>See the API Explorer for a full list of activity definition properties to update.</li>
</ul>
```ruby
        new_activity_definition.adjustment = {:points => 3}
        success = new_activity_definition.save

        activity_def_points_updated = BadgevilleBerlin::ActivityDefinition.find(new_activity_definition.id)
        puts activity_def_points_updated["points"]["definition"] # 3
```

### 4. Update the properties of activity definition: enable rate-limiting. [(more on rate-limiting)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-BehaviorRateLimits)
<ul>
  <li>Here we update the activity definition to make it rate-limiting to prevent players from gaming the system.</li>
  <li>See the API Explorer for a full list of activity definition properties to update.</li>
</ul>
```ruby
        activity_def_points_updated.enable_rate_limiting   = true
        activity_def_points_updated.bucket_drain_rate      = 180
        activity_def_points_updated.bucket_max_capacity    = 25
        activity_def_points_updated.save

        activity_def_rate_limit_updated = BadgevilleBerlin::ActivityDefinition.find(new_activity_definition.id)
        puts activity_def_rate_limit_updated.enable_rate_limiting # true
```

### 5. Create a reward definition. [(more on rewards)](http://rules.badgeville.com/display/doc/Creating+and+Managing+DGE+Rewards)
<ul>
  <li>Create a reward definition to specify criteria to earn a particular reward.</li>
  <li>Here we create a reward definition to specify that a player receive a reward for making at least 1 comment.</li>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>
```ruby
        new_reward_def = BadgevilleBerlin::RewardDefinition.new(
          :site_id          => new_site.id,
          :name             => 'Comment Rockstar',
          :reward_template  => '{"message":"Congrats, you are a Comment Rockstar!"}',
          :components       => '[{"comparator":{"$gte":1},"where":{"verb":"comment","player_id":"%player_id"},"command":"count"}]',
          :active           => true )
        new_reward_def_created = new_reward_def.save
```

### 6. Register a player behavior.
<ul>
  <li>Here we record the fact that the newly created player performed a "comment" behavior.</li>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>
```ruby
        new_activity = BadgevilleBerlin::Activity.new(
          :verb      => 'comment',
          :player_id => new_player.id )
        success = new_activity.save
```

### 7. Find the updated player to verify properties and rewards.
<ul>
  <li>Here we verify that the player was credited 4 points and received a reward for the comment behavior.</li>
  <li>Print out the BadgevilleBerlin::Player object (i.e. updated_player) to get a full list of player properties.</li>
</ul>
```ruby
        updated_player = BadgevilleBerlin::Player.find(new_player.id)
        puts updated_player.points_all # 3.0

        player_specific_rewards = BadgevilleBerlin::Reward.find(:all, :params => {:player_id => @new_player.id})
        puts player_specific_rewards[0].name # "Comment Rockstar"

```

### 8. Delete a reward definition. 
<ul>
  <li>A reward definition can only be deleted if associated earned rewards have been deleted.</li>
</ul>
```ruby
        BadgevilleBerlin::RewardDefinition.delete(new_reward_def.id)
```
## Dependencies, Installation & Documentation
Please see the [Basic README](https://github.com/badgeville/badgeville-ruby/blob/alpha/README.markdown) for details.

## Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper.


Copyright (c) 2012 Badgeville.