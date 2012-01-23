# Badgeville RESTful Wrapper for Berlin API (Basic README)

This is a Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).

## Features
* Uses the activeresource (3.0.5) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Uses a logger to print HTTP requests to the standard output stream.

##Basic Examples

### Configure the gem to use your Badgeville API Key and the site to which your requests should go.
```ruby
Badgeville::Config.conf(
  :site    => "http://staging.badgeville.com",
  :api_key => "007857cd4fb9f360e120589c34fea080")
```

### 1. Add a new site to your network. Find your network ID the Publisher Module's tabbed menu Develop > Home or contact support@badgeville.com.
```ruby
new_site = Badgeville::Site.new(
  :name       => "My Website",
  :url        => "mydomain.com",
  :network_id => '4d5dc61ed0c0b32b79000001' )
success = new_site.save
```

### Create a user to add them to your network.

```ruby
new_user = Badgeville::User.new(
  :name       => 'visitor_username',
  :network_id => '4d5dc61ed0c0b32b79000001',
  :email      => 'visitor@emailserver.com',
  :password   => 'visitor_password' )
success = new_user.save
```

### Find the newly created user by ID to update their email address.

```ruby
user_found_by_id       = Badgeville::User.find( new_user.id )
user_found_by_id.email = 'revised_visitor@emailserver.com'
success                = user_found_by_id.save
```

### Create a player using the user corresponding to the updated email address for the site you created.

```ruby
new_player = Badgeville::Player.new(
  :site_id => new_site.id,
  :user_id => new_user.id )
success   = new_player.save
```

### Register a player behavior (comment) for the newly created player.

```ruby
new_activity = Badgeville::Activity.new(
  :verb      => 'comment',
  :player_id => new_player.id )
success = new_activity.save
```

##Dependencies
* activeresource (3.1.3) - Provides Ruby classes to RESTfully interact with remote resources.
* logger (1.2.8) - Provides logging to the standard output stream.

## Installation

## Documentation

For more documentation on how the Badgeville RESTful Berlin API works, see [here] (http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).

##Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation is available here.

##Feedback
Please email your comments to supraja@badgeville.com

Copyright (c) 2012 Badgeville.