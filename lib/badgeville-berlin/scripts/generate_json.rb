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
    PORT = "80"
    @@site_id = 0
    @@group_id = 0

    #[Activity, ActivityDefinition, Group, Leaderboard, Player, Reward, RewardDefinition, Site, Track, User].each do |module_klass|
    #attr_accessor :site_id

    def self.site_id
      @@site_id
    end

    def self.site_id=(site_id)
      @@site_id = site_id
    end

    def self.group_id
      @@site_id
    end

    def self.group_id=(site_id)
      @@site_id = site_id
    end

    def self.yml
      [BadgevilleBerlin::Site, BadgevilleBerlin::Group].each do |module_klass|

        #Create
        klass = module_klass.to_s.split('::')[1].underscore

        case klass
          when "site"
            o =  [('a'...'z'),('A'...'Z')].map{|i| i.to_a}.flatten
            string  =  (0..15).map{ o[rand(o.length)]  }.join
            options = {:name => string, :url => "#{string}.com" }
          when "group"
            o =  [('a'...'z'),('A'...'Z')].map{|i| i.to_a}.flatten
            string  =  (0..15).map{ o[rand(o.length)]  }.join
            options = {:site_id => self.site_id, :name => string }
        end

        puts "curl -d '#{build_options(klass,options)}'  '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}.json'"
        response = `curl -d '#{build_options(klass,options)}'  '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}.json'`
        puts response
        create_hash = eval(response.gsub('":','"=>').gsub("null","\"null\""))

        case klass
          when "site"
            self.site_id= create_hash["id"]
            puts "SITE ID IS #{self.site_id}"
          when "group"
            self.group_id = create_hash["id"]
        end

        puts create_hash.to_yaml
      end
    end

    def self.build_options(klass, opt)
      str = ""
      opt.each do |key,val|
        str << "#{klass}[#{key}]=#{val}&"
      end
      str[0..-2]
    end

  end
end

gen = BadgevilleBerlin::Generate.yml

