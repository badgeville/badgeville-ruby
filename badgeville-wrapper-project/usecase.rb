require 'ruby-debug'

require_relative 'badgeville_wrapper.rb'

user_id = '4f05ef5ea768651b3500009f'
site_id = '4f05e84aa768651b300000bc'


#********** CREATE A NEW SITE -- SUCCEEDED **********#
# new_site = Site.new(:name => "My Website To Delete", :url => "mydomaindelete.com",
#   :network_id => '4d5dc61ed0c0b32b79000001')
# success = new_site.save
# if (!success)
#   puts new_site.errors.messages
# else
#   puts "Creation of a new site succeeded"
#   puts new_site.name, new_site.url, new_site.id
# end


#********** UPDATE A SITE -- SUCCEEDED **********#
request_site  = 'http://staging.badgeville.com/'
my_apikey     = '007857cd4fb9f360e120589c34fea080'
BaseResource.config(request_site, my_apikey)

new_site = Site.find(site_id)
new_site.name = 'My Revised Website Name'
new_site.save
p new_site.name


#********** UPDATE A SITE -- SUCCEEDED **********#
# Site.delete('4f079a04a76865329a000087')


#********** FIND USER BY EMAIL -- SUCCEEDED **********#
# p User.find('paul@badgeville.com')

#********** DELETE A USER -- SUCCEEDED **********#
# user_id_to_delete = '4f04f428a768655c81000008'
# user_to_delete    = User.find(user_id_to_delete);
# User.delete(user_id_to_delete)

#********** CREATE A NEW USER -- SUCCEEDED **********#
# new_user = User.new(:name => 'visitor_username', :network_id => '4d5dc61ed0c0b32b79000001', :email => 'visitor@emailserver.com', :password => 'visitor_password');
# success = new_user.save
# if (!success)
#   puts new_user.errors.messages
# else
#   puts "Creation of a new user succeeded"
#   puts new_user.id, new_user.created_at, new_user.name, new_user.email
# end

#********** UPDATE A NEWLY CREATED USER -- SUCCEEDED **********#
# user_id = '4f05ef5ea768651b3500009f'
# user_found_by_id = User.find(user_id)
# p user_found_by_id.known_attributes
# user_found_by_id.email = 'revised_visitor@emailserver.com'
# success = user_found_by_id.save
# if (!success)
#   puts user_found_by_id.errors.messages
# else
#   puts "Updating user succeeded"
#   puts user_found_by_id.id, user_found_by_id.created_at, user_found_by_id.name, user_found_by_id.email
# end

#********** CREATE A NEW PLAYER -- SUCCEEDED **********#

# user_id =  User.find('supraja220494@badgeville.com').id
# site_id = '4f05e84aa768651b300000bc'
# new_player = Player.new(:site_id => site_id, :user_id => user_id);
# success = new_player.save
# if (!success)
#  puts new_player.errors.messages
# else
#   puts "Creation of a new player succeeded"
#   puts new_player.email
#   puts new_player.id
#   #supraja220494@badgeville.com
#   #4f0b29bca76865329a0000ae
#
#   # supraja220494@badgeville.com
#   # 4f0b4032a768656c9d000010
# end

#*********** UPDATE A PLAYER -- SUCCEEDED **********#
# player_to_update = Player.find('4f0b29bca76865329a0000ae')
# p player_to_update.display_name
# player_to_update.display_name = 'Supraja'
# player_to_update.save
# player_to_update = Player.find('4f0b29bca76865329a0000ae')
# p player_to_update.display_name

#********** REMOVE A PLAYER FROM LEADERBOARDS -- SUCCEEDED **********#
#To remove a player from a leaderboard, you can set the admin property of a player to true.
# player_to_update = Player.find('4f0b29bca76865329a0000ae')
# p player_to_update.admin
# player_to_update.admin = true
# player_to_update.save
# player_to_update = Player.find('4f0b29bca76865329a0000ae')
# p player_to_update.admin

#********** DELETE A PLAYER -- SUCCEDED *********#
# player_id_to_delete = '4f0b29bca76865329a0000ae'
# player_to_delete    = Player.find(player_id_to_delete)
# p player_to_delete.id
# Player.delete(player_id_to_delete)

#********** CREATE AN ADVANCED ACTIVITY DEFINTION -- SUCCEEDED **********#
# site_id = '4f05e84aa768651b300000bc'
# new_activity_definition = ActivityDefinition.new(:adjustment => {:points => 5}, :name => 'rate blog post', :site_id => site_id, :verb => 'comment',
#  :enable_rate_limiting => true, :bucket_drain_rate => 3600, :bucket_max_capacity => 1)
# success = new_activity_definition.save
# if (!success)
#   p new_activity_definition.errors.messages
# else
#   p new_activity_definition.id, new_activity_definition.known_attributes
# end

#********** DELETE AN ACTIVITY DEFINITION -- ? **********#
# activity_definition_id = '4f0b435ea768656ca400001b'
# ActivityDefinition.delete(activity_definition_id)
# ActivityDefinition.find(activity_definition_id)

#*********** GET KNOWN ATTRIBUTES FOR AN ACTIVITY DEFINTION - SUCCEEDED **********#
# activity_def_id = '4f05fc80a768651b300000db'
# ad = ActivityDefinition.find(activity_def_id)
# puts ad

#*********** FIND OUT HOW MANY POINTS A GIVEN ACTIIVITY IS WORTH - SUCCEEDED **********#
#activity_def_id = '4f05fc80a768651b300000db'
#ad = ActivityDefinition.find(activity_def_id)
# puts ad.adjustment.points

#*********** REGISTER A PLAYER BEHAVIOR - SUCCEEDED **********#
# new_player = Player.find('4f0b4032a768656c9d000010')
# new_activity = Activity.new( :verb => 'rate blog post', :player_id => new_player.id)
# success = new_activity.save
# if (!success)
#   puts new_activity.errors.messages
# else
#   puts "Creation of a new activity succeeded"
#   puts new_activity.id, new_activity.verb
# end
# p new_player.points_all
# Creation of a new activity succeeded
# 4f0b386ea768656c9d000005
# read blog post
# Creation of a new activity succeeded
# 4f06062ca768651b350000bf
# comment

#********** FIND THE SITE ASSOCIATED WITH THIS PLAYER -- **********#
# p Player.find('4f05f6b7a768651b300000cc').email
# site_id_to_find  = Player.find('4f05f6b7a768651b300000cc').site_id
# p Site.find(site_id_to_find).name


#revised_visitor@emailserver.com
# new_user2 = User.new( :name => 'visitor2_username', :network_id => '4d5dc61ed0c0b32b79000001', :email => 'visitor2@emailserver.com', :password => 'visitor2_password' );
# success = new_user2.save
# if (!success)
#   puts new_user2.errors.messages
# else
#   puts "Creation of a new user succeeded"
#   puts new_user2.id, new_user2.created_at, new_user2.name, new_user2.email
# end
#4f0608c1a768651b350000c4

#********** CREATE A PLAYER AND REGISTER A NEW TYPE OF PLAYER BEHAVIOR ON THE FLY -- FAILED **********
# Because creating a player on the fly is not RESTful. #

# new_site  = Site.find('4f05e84aa768651b300000bc')
# new_user2 = User.find('4f0608c1a768651b350000c4')
# new_activity_share = Activity.new( :verb => 'suprajatestactivity', :site_id => new_site.id, :user_id => new_user2.id )
# #new_activity_share = Activity.new( :verb => 'share', :site_id => new_site.id, :user_id => new_user2.id )
#
# success = new_activity_share.save
# p new_activity_share
# if (!success)
#   puts new_activity_share.errors.messages
# else
#   puts "Creation of a new activity succeeded"
#   puts new_activity_share.id, new_activity_share.verb
# end

# I, [2012-01-05T12:47:11.779770 #16135]  INFO -- : --> 422 Unprocessable Entity 32 (302.8ms)
# {:base=>["Player can't be blank"]}

#********** CREATE A REWARD DEFINITION **********#
# 'reward_definition\[site_id\]=site_id&
# reward_definition\[name\]=name&reward_definition\[reward_template\]=\{"message":"Congrats!"\}&
# reward_definition\[components\]=\[\{"command":"count","comparator":1,"where":\{"verb":"verb","player_id":"%player_id"\}\}\]'

# old_prefix = Site.prefix
# Site.apikey = '007857cd4fb9f360e120589c34fea080/'
# Site.prefix = old_prefix + Site.apikey
# new_site  = Site.find('4f05e84aa768651b300000bc')
# debugger
# new_reward_definition =
#   RewardDefinition.new( :site_id          => new_site.id,
#                         :name             => 'reward3blogpost_ratings',
#                         :reward_template  => { :message => 'Congrats!' },
#                         :components       => {  :command => 'count',
#                                                 :comparator => 3,
#                                                 :where => { :verb => 'rate blog post', :player_id => '%player_id' }
#                                              }
#                       )
# success = new_reward_definition.save
# p new_reward_definition.id
# p new_reward_definition._id
#
# p new_reward_definition.errors
# GET /api/berlin/private_api_key/activity_definitions.json?site=site.com
#last_activity_id = Activity.first.id
#p last_activity_id

#********** CREATE AN ACTIVITY DEFINTION -- SUCCEEDED **********#
# NO :adjustment => {:points => 5}, :enable_rate_limiting => true, :bucket_drain_rate => 3600, :bucket_max_capacity => 1
# site_id = '4f05e84aa768651b300000bc'
# new_site = Site.find('4f05e84aa768651b300000bc')
# new_activity_definition = ActivityDefinition.new( :name => 'comment_supraja_test2', :site_id => new_site.id, :verb => 'comment', :adjustment => {:points => 4} )
# success = new_activity_definition.save
# if (!success)
#   p new_activity_definition.errors.messages
# else
#   p new_activity_definition.id, new_activity_definition.adjustment.points
# end

#********** UPDATE AN ACTIVITY DEFINITION -- SUCCEEDED **********#
# activity_definition_id = '4f0748ada76865329a000035'
# new_activity_definition = ActivityDefinition.find(activity_definition_id)
# #new_activity_definition.adjustment.points = 5
# p new_activity_definition.adjustment.points
#success = new_activity_definition.save
# if (!success)
#   p new_activity_definition.errors.messages
# else
#   p new_activity_definition.id, new_activity_definition.adjustment.points
# end


#********** LIST ACTIVITY DEFINITIONS BY SITE -- SUCCESS **********#
# Works for mydomain.com and ibadgeyou.com
#activities = ActivityDefinition.find(:all, :params => {:site => 'mydomain2.com' } )
# activities = ActivityDefinition.find(:all, :params => {:site => 'ibadgedyou.com' } )
# activities.each do |a|
#   p a.id, a.verb, a.adjustment
# end


# This works pretty well! Only thing is that ActivityDeinition::Adjustment::points
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc3729c5558 @attributes={}, @prefix_options={}, @persisted=false>
# "4f05fbf0a768651b350000bb"
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc3729c08f0 @attributes={}, @prefix_options={}, @persisted=false>
# "4f05fc80a768651b300000db"
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc3729bcdb8 @attributes={"points"=>5}, @prefix_options={}, @persisted=false>
# "4f074517a76865329a000033"
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc372982140 @attributes={"points"=>4}, @prefix_options={}, @persisted=false>
# "4f0748ada76865329a000035"
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc372961008 @attributes={"points"=>4}, @prefix_options={}, @persisted=false>
# "4f0b445fa768656c9d00001b"
# "comment"
# #<ActivityDefinition::Adjustment:0x007fc372959538 @attributes={"points"=>5}, @prefix_options={}, @persisted=false>
# "4f0b4236a768656c9d000016"
# "read blog post"
# #<ActivityDefinition::Adjustment:0x007fc372955c30 @attributes={"points"=>7}, @prefix_options={}, @persisted=false>

#********** LIST ACTIVITIES BY SITE -- SUCCESS **********#
# activities = Activity.find(:all, :params => {:site => 'mydomain2.com' } )
# activities.each do |a|
#   p a.id, a.verb, a.points, a.verb, a.rewards
# end
# "4f0b412ca768656c9d000014"
# "comment"
# 0


#********** LIST REWARD DEFINITIONS BY SITE -- ERROR THAT NEEDS TO BE RESOLVED ***********#
# rds = RewardDefinition.find(:all)
# rds.each do |rd|
#   p rd.known_attributes
# end
# Here is an example of a record from the call to collect!
# {"type"=>"level",
#  "name"=>"Advanced",
#  "created_at"=>"2012-01-09T12:45:04-08:00",
#  "assignable"=>false,
#  "allow_duplicates"=>false,
#  "components"=>"[{\"comparator\":{\"$gte\":10},\"command\":\"sum\",\"where\":{\"player_id\":\"%player_id\"},\"config\":{}}]",
#  "reward_template"=>{"message"=>""},
#  "tags"=>nil, "site_id"=>"4f05e84aa768651b300000bc",
#  "image_url"=>"http://staging.badgeville.com/images/misc/missing_badge.png",
#  "image_file_name"=>nil,
#********** THE CRITICAL LINE IS HERE: "data"=>{"start_points"=>10, "position"=>3},
#  "_id"=>"4f0b51d0a768656c9d000036", "id"=>"4f0b51d0a768656c9d000036", "active"=>false, "hint"=>"", "message"=>"", "active_start_at"=>nil, "active_end_at"=>nil}

# This line suggests that a RewardDefinition has an attribute called data.  Verify that this is correct in the Berlin API.
#********** LIST ACTIVITIES BY PLAYER EMAIL *********#


#********** UPDATE AN ACTIVITY -- ALREADY FORBIDDEN AS EXPECTED **********#
# activity_id_to_update = "4f0b412ca768656c9d000014"
# activity_to_update    = Activity.find(activity_id_to_update)
# activity_to_update.points = 9
# activity_to_update.save
# activity_to_update    = Activity.find(activity_id_to_update)
# p activity_to_update.points

#********** DELETE AN ACTIVITY -- ????? **********#
# activity_id_to_delete = "4f0b412ca768656c9d000014"
# Activity.delete(activity_id_to_delete)


#********** PRINT THE KNOWN ATTRIBUTES FOR AN ACTIVITY DEFINITION -- SUCCEEDED **********#
# activity_definition_id = '4f0748ada76865329a000035'
# new_activity_definition = ActivityDefinition.find(activity_definition_id)
# puts new_activity_definition.known_attributes