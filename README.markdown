# badgeville

Ruby gem for interacting with the [Badgeville API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation)

# Installation

`gem install badgeville`

or if you are using a `Gemfile`, use

`gem 'badgeville', '1.0.0'`

# Examples

## Create an instance for interacting with Badgeville

```ruby
@badgeville = Badgeville::API.new('thisisyourbadgevilleapikey')
```

## Create a user and then a player for that user

```ruby
badgeville_response = @badgeville.create_user(
  :user => {
    :name => 'Player Name', 
    :email => 'player_name@yoursite.com'
  }
)

badgeville_response = @badgeville.create_player(:email => 'player_name@yoursite.com', 
  :site => 'yoursite.com', :player => {:email => 'player_name@yoursite.com'}, :verbose => true)
```

## Create an activity definition

```ruby
badgeville_response = @badgeville.create_activity_definition(
  :activity_definition => {
    :site_id => '4d700bd351c21c1e3c000004',
    :name => 'API test (V2) activity - gem test',
    :selector => '{"verb":"api_test_v2_gem"}',
    :adjustment => '{"points":5}'
  }
)
```

## Create a reward definition

```ruby
badgeville_response = @badgeville.create_reward_definition(
  :reward_definition => {
    :site_id => '4d700bd351c21c1e3c000004',
    :name => 'API test (V2) reward - gem test',
    :components => '[{"comparator":{"$gte":1},"command":"count","where":{"verb":"api_test_v2_gem","user_id":"%user_id","site_id":"%site_id"}}]',
    :reward_template => '{"message":"Congratulations! You\'ve won the API test V2 badge!"}',
    :tags => 'API,test,v2',
    :active => true
  }
)
```

## Submit activity for a player

```ruby
badgeville_response = @badgeville.create_activity(
  :player_id => '4ee7bc0c3dc64810b0000157',
  :activity => {:verb => 'api_test_v2_gem'}
)
```



# Compatibility

The gem has been built under Ruby 1.9.3, but should be fine to use under Ruby 1.9.2 or Ruby 1.8.7.

# Contributing to badgeville
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2011 David Czarnecki. See LICENSE.txt for further details.