# badgeville

Ruby gem for interacting with the [Badgeville API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation)

# Installation

`gem install badgeville`

or if you are using a `Gemfile`, use

`gem 'badgeville', '1.0.0'`

# Examples

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