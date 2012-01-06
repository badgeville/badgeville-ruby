#Badgeville RESTful Wrapper for Berlin API (Advanced README)
This is a Ruby wrapper for the Badgeville RESTful Berlin API.

##Getting Started
* Please check out the [Basic README](https://github.com/badgeville/badgeville-ruby/blob/alpha/badgeville_wrapper_project/README.md) first.

##Advanced Example Usage

1. ### Create an activity definition to specify that a player will earn 4 points each time they perform the "comment" behavior.
        ```ruby
        new_activity_definition = ActivityDefinition.new( :adjustment => {:points => 4},
                                                          :name => 'comment_earns_4points',
                                                          :site_id => new_site.id,
                                                          :verb => 'comment' )
        success = new_activity_definition.save
        ```

2. ### Update the activity definition such that a player on your site will earn 3 points rather than 4 each time they perform the "comment" behavior. [(more)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors)
        ```ruby
        new_activity_definition.adjustment.points = 3
        success = new_activity_definition.save
        ```

3. ### Update the activity definition to include a rate limit in order to block players from gaming the system. [(more)](http://rules.badgeville.com/display/doc/Creating+and+Managing+Behaviors#CreatingandManagingBehaviors-CreatingSimpleBehaviors)
* Set bucket_rate_limit to 180 (20 comments per hour).
  ** Why? 180 (3600 (number of seconds in an hour) / 20 comments = 180 s. This will drain 1 comment every 3 minutes.
* Set bucket_max_capacity to 25.
  ** Why? This allows the player to create 25 comments as fast as they like, after which the bucket will begin to drain.

          ```ruby
          new_activity_definition.enable_rate_limiting = true
          new_activity_definition.bucket_drain_rate    = 180
          new_activity_definition.bucket_max_capacity  = 25
          new_activity_definition.save
          ```

4. ### Reward definitions define numerous criteria that must be met for a player to earn a reward. Create a reward definition to reward a player when they have made two comments.
        ```ruby
        new_reward_definition =
          RewardDefinition.new( :site_id          => new_site.id,
                                :name             => 'reward_2comments',
                                :reward_template  => { :message => 'Congrats!' },
                                :components       => {  :command => 'count',
                                                        :comparator => 2,
                                                        :where => { :verb => 'comment', :player_id => '%player_id' }
                                                      } )
        success = new_reward_definition.save
        ```

Dependencies
-------------
* rubygems - Your gem manager.
* activeresource (3.1.3) - Provides Ruby classes to RESTfully interact with remote resources.
* logger (1.2.8) - Provides logging to the standard output stream.


Installation
-------------
1. Put this file in the same directory as your Ruby script.
2. Then include this line near the top of your Ruby script:

        ```ruby
        require_relative 'badgeville_wrapper.rb'
        ```

Configuration
-------------
Badgeville Private API Key: This is hardcoded for now.


Documentation
-------------
For more documentation on how Badgeville works [see here](http://rules.badgeville.com/).


Contributors
------------
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation are available [here](https://github.com/badgeville/badgeville-ruby).


Feedback
--------
Please email your comments to <supraja@badgeville.com>

Copyright
---------
Copyright (c) 2012 Badgeville.