Badgeville RESTful Wrapper for Berlin API (Basic README)
--------------------------------------------------------
This is a Ruby wrapper for the Badgeville RESTful Berlin API.

Features
--------
* Uses the activeresource (3.0.5) gem to map ActiveModel-like RESTful methods to resources on the remote Badgeville server.
* Uses a logger to print HTTP requests to the standard output stream.


Basic Examples
--------------

1. ### Add a new site to your network.
Find your network ID the Publisher Module's tabbed menu Develop > Home or contact <support@badgeville.com>.
        ```ruby
        new_site = Site.new(  :name => "My Website",
                              :url => "mydomain.com",
                              :network_id => '4d5dc61ed0c0b32b79000001' )
        success = new_site.save
        ```

2. ### Create a user to add them to your network.
        ```ruby
        new_user = User.new(  :name => 'visitor_username',
                              :network_id => '4d5dc61ed0c0b32b79000001',
                              :email => 'visitor@emailserver.com',
                              :password => 'visitor_password' )
        success = new_user.save
        ```

3. ### Find the newly created user by ID to update their email address.
        ```ruby
        user_found_by_id       = User.find( new_user.id )
        user_found_by_id.email = 'revised_visitor@emailserver.com'
        success                = user_found_by_id.save
        ```

4. ### Create a player using the user corresponding to the updated email address for the site mydomain.com.
        ```ruby
        new_player = Player.new(  :site_id => new_site.id,
                                  :user_id => new_user.id )
        success   = new_player.save
        ```

5. ### Register a player behavior (comment) for the newly created player.
        ```ruby
        new_activity = Activity.new(  :verb => 'comment',
                                      :player_id => new_player.id )
        success = new_activity.save
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
David Czarnecki of Major League Gaming wrote the initial gem that inspired this wrapper. David's gem and supporting documentation is available [here](https://github.com/badgeville/badgeville-ruby).


Feedback
--------
Please email your comments to <supraja@badgeville.com>

Copyright
---------
Copyright (c) 2012 Badgeville.
