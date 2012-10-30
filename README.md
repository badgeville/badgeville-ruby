# Badgeville RESTful Wrapper for Berlin API -- Basic README

This is an open source Ruby wrapper for interacting with the [Badgeville RESTful Berlin API](http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Features
* Uses the activeresource (3.1.3) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Allows creating, reading (finding), updating and deleting the following classes of remote resources: Site, User, Player, ActivityDefinition, Activity, Reward and RewardDefinition.

##Basic Examples

### 1. Configure the gem to use your Badgeville Private API Key and the site to which your requests should go.
```ruby
        BadgevilleBerlin::Config.conf(
          :host_name => "http://example.com",
          :api_key   => MY_API_KEY)
```
:host_name should be the Badgeville endpoint that receives your calls, NOT your site URL.  Example: "http://sandbox.v2.badgeville.com"

### 2. Add a new site to your network. Find your network ID the Publisher Module's tabbed menu ( Develop > Home ) or contact <support@badgeville.com>
```ruby
        new_site = BadgevilleBerlin::Site.new(
          :name       => "My Website",
          :url        => "mydomain.com",
          :network_id => MY_NETWORK_ID )
        success = new_site.save
```

### 3. Create a user on your network.
<ul>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>

```ruby
        new_user = BadgevilleBerlin::User.new(
          :name       => 'visitor_username',
          :network_id => MY_NETWORK_ID,
          :email      => 'visitor@emailserver.com',
          :password   => 'visitor_password' )
        success = new_user.save
```

### 4. See error messages from the remote server.
<ul>
  <li>Here we attempt to create a second user on the network with the same email as the first user.</li>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>

```ruby
        new_user2 = BadgevilleBerlin::User.new(
          :name       => 'visitor_username',
          :network_id => MY_NETWORK_ID,
          :email      => 'visitor@emailserver.com',
          :password   => 'visitor_password' )
        success = new_user2.save

        puts new_user2.errors.messages # {:email=>["user email is already taken"]}
        puts new_user2.errors[:email]  # ["user email is already taken"]

```

### 5. Find a user to update user properties.
<ul>
  <li>Here we find the newly created user by ID to update their email address.</li>
  <li>See the API Explorer for a full list of user properties to update.</li>
</ul>
```ruby
        user_found_by_id = BadgevilleBerlin::User.find( new_user.id )
        user_found_by_id.email = 'revised_visitor@emailserver.com'
        success = user_found_by_id.save

        updated_user = BadgevilleBerlin::User.find( new_user.id )
        puts updated_user.email # revised_visitor@emailserver.com
```

### 6. Create a player.
<ul>
  <li>Here we create a player for the new site, corresponding to the user with the updated email address.</li>
  <li>See the API Explorer for required and optional parameters.</li>
</ul>
```ruby
        new_player = BadgevilleBerlin::Player.new(
          :site_id => new_site.id,
          :user_id => user_found_by_id.id )
        success = new_player.save
```

### 7. Find existing players by email.
<ul> 
  <li>Here we find an existing player by email.</li>
  <li>To get all players on the network that match the email, we have passed :all.</li>
  <li>You can alternatively pass :first or :last in the place of :all.</li>
</ul>
``` ruby
        @existing_player = Player.find(:all, :params => {:email => "revised_visitor@emailserver.com"})
```

### 8. Register a player behavior.
<ul>
  <li>Here we record the fact that the newly created player performed a "share" behavior.</li>
  <li>See the API Explorer for required and optional parameters.</li>
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
gem install badgeville_berlin


## Documentation
For more documentation on how the Badgeville RESTful Berlin API works, see [here] (http://rules.badgeville.com/display/doc/2.0+Core+API+Documentation).


## Submitting an Issue
You can use the [GitHub issue tracker](https://github.com/badgeville/badgeville-ruby/issues) to report bugs. After ensuring that the bug has not already been submitted, please submit:

1. A [gist](https://gist.github.com/) a that contains a stack trace.
2. Details needed to reproduce the bug, including gem version, Ruby version and operating system.


## Submitting a Pull Request
1. Click the GitHub "Fork" button to fork this project.
2. Clone the repository for a local copy:

        git clone git@github.com:username/badgeville-ruby.git

3. Create a topic branch:

        git checkout -b my_bug_fix_or_feature_branch

4. Add documentation and specs for your bug fix or feature.
5. Implement your bug fix or feature.
6. Run the following command to ensure your tests cover your changes:

        bundle exec rake spec

7. Commit and push your changes.
8. Click the GitHub "Pull Request" to submit a pull request. Please do not include changes to the gemspec, version or history file.

## Contributors
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper.


Copyright (c) 2012 Badgeville.