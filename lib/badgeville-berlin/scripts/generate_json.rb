require 'httparty'
require 'active_resource'

# Adds BadgevilleBerlinJson custom format.
require "badgeville-berlin/formats/badgeville_berlin_json_format.rb"

# Subclasses ActiveResource.
require "badgeville-berlin/base_resource.rb"
require "badgeville-berlin/config.rb"
require "badgeville-berlin/errors.rb"

# Subclasses for remote resources.
require "badgeville-berlin/activity.rb"
require "badgeville-berlin/activity_definition.rb"
require "badgeville-berlin/group.rb"
require "badgeville-berlin/leaderboard.rb"
require "badgeville-berlin/player.rb"
require "badgeville-berlin/reward.rb"
require "badgeville-berlin/reward_definition.rb"
require "badgeville-berlin/site.rb"
require "badgeville-berlin/track.rb"
require "badgeville-berlin/user.rb"

# Adds logger to print out HTTP requests and responses.
require "badgeville-berlin/logger.rb"

module BadgevilleBerlin
  class Generate
    HOST = "http://staging.badgeville.com"
    APIKEY = "6f8d6fef49a462279eeca363fa1a30b5"
    ENDPOINT = "/api/berlin/"
    ENDPOINTKEY = ENDPOINT + APIKEY
    NETWORKID = "4d5dc61ed0c0b32b79000001"
    PORT = "80"
    @@site_id = 0
    @@site_name = ""
    @@group_id = 0
    @@group_name = ""
    @@leaderboard_id = 0
    @@leaderboard_name = ""
    @@player_id = 0
    @@player_name = ""
    @@user_id = 0
    @@user_name = ""
    @@user_email = ""
    #[Activity, ActivityDefinition, Group, Leaderboard, Player, Reward, RewardDefinition, Site, Track, User].each do |module_klass|
    #curl -d 'leaderboard[network_id]=4d5dc61ed0c0b32b79000001&leaderboard[name]=Underwater Basketweaving Leaderboard&leaderboard[selector]={}&leaderboard[field]=%2B5&leaderboard[command]=5&leaderboard[label]=ubl' 'http://staging.badgeville.com/api/berlin/6f8d6fef49a462279eeca363fa1a30b5/leaderboards.json'

    #attr_accessor :site_id

    def self.site_id
      @@site_id
    end

    def self.site_id=(site_id)
      @@site_id = site_id
    end

    def self.site_name
      @@site_name
    end

    def self.site_name=(site_name)
      @@site_name = site_name
    end

    def self.group_id
      @@group_id
    end

    def self.group_id=(group_id)
      @@group_id = group_id
    end

    def self.group_name
      @@group_name
    end

    def self.group_name=(group_name)
      @@group_name = group_name
    end

    def self.leaderboard_id
      @@leaderboard_id
    end

    def self.leaderboard_id=(leaderboard_id)
      @@leaderboard_id = leaderboard_id
    end

    def self.leaderboard_name
      @@leaderboard_name
    end

    def self.leaderboard_name=(leaderboard_name)
      @@leaderboard_name = leaderboard_name
    end

    def self.player_id
      @@player_id
    end

    def self.player_id=(player_id)
      @@player_id = player_id
    end

    def self.player_name
      @@player_name
    end

    def self.player_name=(player_name)
      @@player_name = player_name
    end

    def self.user_id
      @@user_id
    end

    def self.user_id=(user_id)
      @@user_id = user_id
    end

    def self.user_name
      @@user_name
    end

    def self.user_name=(user_name)
      @@user_name = user_name
    end

    def self.user_email
      @@user_email
    end

    def self.user_email=(user_email)
      @@user_email = user_email
    end


    def self.yml
      [BadgevilleBerlin::Site, BadgevilleBerlin::Group, BadgevilleBerlin::Leaderboard, BadgevilleBerlin::User,
       BadgevilleBerlin::Player].each do |module_klass|

        #Create
        klass = module_klass.to_s.split('::')[1].underscore

        o =  [('a'...'z'),('A'...'Z')].map{|i| i.to_a}.flatten
        string  =  (0..15).map{ o[rand(o.length)]  }.join

        case klass
          when "site"
            options = {:name => string, :url => "#{string}.com" }
          when "group"
            options = {:site_id => self.site_id, :name => string }
          when "leaderboard"
            options = {:network_id => NETWORKID, :name => string, :selector => {}, :field => "%2B5", :command => 5, :label => string }
          when "user"
            options = {:name => string, :email => "#{string}@badgeville.com"}
          when "player"
            options = {:email! => self.user_email, :site! => "#{self.site_name}.com",
                       :email => self.user_email, :first_name => string,
                       :last_name => string}
        end

        puts "curl -d '#{build_options(klass,options)}'  '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}.json'"
        response = `curl -d '#{build_options(klass,options)}'  '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}.json'`
        puts response
        create_hash = eval(response.gsub('":','"=>').gsub("null","\"null\""))

        if klass == "user"
          self.send "#{klass}_id=", create_hash["_id"]
          self.send "#{klass}_email=", create_hash["email"]
        else
          self.send "#{klass}_id=", create_hash["id"]
        end

        self.send "#{klass}_name=", create_hash["name"]

        puts create_hash.to_yaml
      end
    end

    def self.build_options(klass, opt)
      str = ""
      opt.each do |key,val|
        if key.to_s.include?("!")
          str << "#{key[0..-2]}=#{val}&"
        else
          str << "#{klass}[#{key}]=#{val}&"
        end
      end
      str[0..-2]
    end

  end
end

gen = BadgevilleBerlin::Generate.yml

