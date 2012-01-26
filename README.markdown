# Badgeville RESTful Wrapper for Berlin API -- Basic README

This is a Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Features
* Uses the activeresource (3.1.3) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Allows creating, reading (finding), updating and deleting the following classes of remote resources: Site, User, Player, ActivityDefinition, Activity.

##Basic Examples

### 1. Configure the gem to use your Badgeville API Key and the site to which your requests should go.
```ruby
BadgevilleBerlin::Config.conf(
  :host_name => "http://example.com",
  :api_key   => MY_API_KEY)
```

### 2. Add a new site to your network.
<ul>
  <li>Find your network ID the Publisher Module's tabbed menu Develop > Home or contact support@badgeville.com.</li>
</ul>
```ruby
new_site = BadgevilleBerlin::Site.new(
  :name       => "My Website",
  :url        => "mydomain.com",
  :network_id => MY_NETWORK_ID )
success = new_site.save
```

### 3. Create a user on your network.
<ul>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for required and optional parameters.</li>
</ul>

```ruby
new_user = BadgevilleBerlin::User.new(
  :name       => 'visitor_username',
  :network_id => MY_NETWORK_ID,
  :email      => 'visitor@emailserver.com',
  :password   => 'visitor_password' )
success = new_user.save
```

### 4. Find a user to update user properties.
<ul>
  <li>Here we find the newly created user by ID to update their email address.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for a full list of user properties to update.</li>
</ul>
```ruby
user_found_by_id = BadgevilleBerlin::User.find( new_user.id )
user_found_by_id.email = 'revised_visitor@emailserver.com'
success = user_found_by_id.save
```

### 5. Create a player.
<ul>
  <li>Here we create a player for the new site, corresponding to the user with the updated email address.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for required and optional parameters.</li>
</ul>
```ruby
new_player = BadgevilleBerlin::Player.new(
  :site_id => new_site.id,
  :user_id => new_user.id )
success = new_player.save
```

### 6. Register a player behavior.
<ul>
  <li>Here we record the fact that the newly created player performed a "share" behavior.</li>
  <li>See the <a href="http://staging.badgeville.com/devcenter/api_explorer/details">API Explorer</a> for required and optional parameters.</li>
</ul>
```ruby
new_activity = BadgevilleBerlin::Activity.new(
  :verb      => 'share',
  :player_id => new_player.id )
success = new_activity.save
```


## Monitoring HTTP Requests and JSON Responses
Print HTTP requests and JSON responses by installing the "logger" gem and including this code in your script.

```ruby
require 'logger'
BadgevilleBerlin::BaseResource.logger       = Logger.new(STDOUT)
BadgevilleBerlin::BaseResource.logger.level = Logger::DEBUG

```

## Dependencies
* activeresource (3.1.3) - Provides Ruby classes to RESTfully interact with remote resources.


## Installation
gem install badgevilleberlin


## Documentation
For more documentation on how the Badgeville RESTful Berlin API works, see [here] (http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).

## Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation is available here.

## Feedback
Please email your comments to supraja@badgeville.com

Copyright (c) 2012 Badgeville.