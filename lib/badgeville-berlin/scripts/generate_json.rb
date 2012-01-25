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
    @@user_email = ""
    @@reward_definition_id = 0
    @@reward_definition_name = ""
    @@reward_id = 0
    @@reward_name = ""
    @@activity_definition_id = 0
    @@activity_definition_name = ""
    @@activity_id = 0
    @@track_id = 0

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

    def self.reward_definition_id
      @@reward_definition_id
    end


    def self.reward_definition_id=(reward_definition_id)
      @@reward_definition_id = reward_definition_id
    end

    def self.reward_definition_name
      @@reward_definition_name
    end

    def self.reward_definition_name=(reward_definition_name)
      @@reward_definition_name = reward_definition_name
    end

    def self.reward_id
      @@reward_id
    end

    def self.reward_id=(reward_id)
      @@reward_id = reward_id
    end

    def self.reward_name
      @@reward_name
    end

    def self.reward_name=(reward_name)
      @@reward_name = reward_name
    end

    def self.activity_definition_id
      @@activity_definition_id
    end
    
    def self.activity_definition_id=(activity_definition_id)
      @@activity_definition_id = activity_definition_id
    end

    def self.activity_definition_name
      @@activity_definition_name
    end

    def self.activity_definition_name=(activity_definition_name)
      @@activity_definition_name = activity_definition_name
    end

    def self.activity_id
      @@activity_id
    end

    def self.activity_id=(activity_id)
      @@activity_id = activity_id
    end

    def self.activity_name
      @@activity_name
    end

    def self.activity_name=(activity_name)
      @@activity_name = activity_name
    end

    def self.track_id
      @@track_id
    end

    def self.track_id=(track_id)
      @@track_id = track_id
    end

    def self.yml
      [BadgevilleBerlin::Site, BadgevilleBerlin::Group, BadgevilleBerlin::Leaderboard, BadgevilleBerlin::User,
       BadgevilleBerlin::Player, BadgevilleBerlin::RewardDefinition, BadgevilleBerlin::Reward,
       BadgevilleBerlin::ActivityDefinition, BadgevilleBerlin::Activity, BadgevilleBerlin::Track].each do |module_klass|

        #Generate create json

        klass = module_klass.to_s.split('::')[1].underscore

        @@o =  [('a'...'z'),('A'...'Z')].map{|i| i.to_a}.flatten
        string  =  (0..15).map{ @@o[rand(@@o.length)]  }.join

        #options hash for create
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
          when "reward_definition"
            options = {:site_id => self.site_id, :name => string, :reward_template => {},
                       :active => false, :allow_duplicates => false, :assignable => false}
          when "reward"
            options = {:site_id => self.site_id, :player_id => self.player_id, :definition_id => self.reward_definition_id}
          when "activity_definition"
            options = {:site_id => self.site_id, :name => string, :selector => "{\"verb\" : \"read\"}", :adjustment => "{\"points\" : 5}" }
          when "activity"
            options = {:verb => string, :player_id! => self.player_id}
          when "track"
            options = {:site_id => self.site_id, :label => string}
        end

        create_response = `curl -d '#{build_options(klass,options)}'  '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}.json'`
        create_hash = eval(create_response.gsub('":','"=>').gsub("null","\"null\""))

        if klass == "user"
          self.send "#{klass}_id=", create_hash["_id"]
          self.send "#{klass}_email=", create_hash["email"]
        elsif klass == "activity_definition"
          self.send "#{klass}_id=", create_hash["_id"]
          self.send "#{klass}_name=", create_hash["name"]
        elsif klass == "activity"
          self.send "#{klass}_id=", create_hash["_id"]
        elsif klass == "track"
          self.send "#{klass}_id=", create_hash["id"]
        else
          self.send "#{klass}_id=", create_hash["id"]
          self.send "#{klass}_name=", create_hash["name"]
        end

        File.open('test_data.yml', 'a') { |f| f.puts create_hash.to_yaml.gsub("\n","\n  ").gsub("---","validate_#{klass}_create:") }

        #Generate find json

        find_response = `curl '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}/#{self.send("#{klass}_id")}.json' `
        find_hash = eval(find_response.gsub('":','"=>').gsub("null","\"null\""))

        File.open('test_data.yml', 'a') { |f| f.puts find_hash.to_yaml.gsub("\n","\n  ").gsub("---","validate_#{klass}_find:") }
    end

    [BadgevilleBerlin::Site, BadgevilleBerlin::Group, BadgevilleBerlin::ActivityDefinition, BadgevilleBerlin::Leaderboard,
    BadgevilleBerlin::Player, BadgevilleBerlin::RewardDefinition, BadgevilleBerlin::Track, BadgevilleBerlin::User].each do |module_klass|
        #Generate update json

        string2 = (0..15).map{ @@o[rand(@@o.length)]  }.join
        puts "STRING 2 is #{string2} #{self.site_id}"
        klass = module_klass.to_s.split('::')[1].underscore

        case klass
          when "site"
            update_options = {:name => string2, :url => "#{string2}.com" }
          when "group"
            update_options = {:name => string2}
          when "activity_definition"
            update_options = {:name => string2, :selector => "{\"verb\" : \"write\"}", :adjustment => "{\"points\" : 10}" }
          when "leaderboard"
            update_options = {:network_id => NETWORKID, :name => string2, :selector => {}, :field => "%2B22", :command => 11, :label => string2 }
          when "player"
            update_options = {:first_name => string2, :last_name => string2}
          when "reward_definition"
            update_options = {:name => string2, :reward_template => {},
                                :active => true, :allow_duplicates => true, :assignable => false}
          when "track"
            update_options = {:site_id => self.site_id, :label => string2}
          when "user"
            update_options = {:name => string2, :email => "#{string2}@badgeville.com"}
        end
        puts "UPDATE RESPONSE #{klass}"

        update_response = `curl -X PUT -d '#{build_options(klass,update_options)}' '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}/#{self.send("#{klass}_id")}.json'`
        puts "curl -X PUT -d '#{build_options(klass,update_options)}' '#{HOST}#{ENDPOINTKEY}/#{klass.pluralize}/#{self.send("#{klass}_id")}.json'"
        update_hash = eval(update_response.gsub('":','"=>').gsub("null","\"null\""))
        File.open('test_data.yml', 'a') { |f| f.puts update_hash.to_yaml.gsub("\n","\n  ").gsub("---","validate_#{klass}_update:") }

        if klass == "user"
          self.send "#{klass}_id=", update_hash["_id"]
          self.send "#{klass}_email=", update_hash["email"]
        elsif klass == "track"
          self.send "#{klass}_id=", update_hash["id"]
        elsif klass == "activity_definition"
          self.send "#{klass}_id=", update_hash["_id"]
          self.send "#{klass}_name=", update_hash["name"]
        else
          self.send "#{klass}_id=", update_hash["id"]
          self.send "#{klass}_name=", update_hash["name"]
        end
    end

    #There is no JSON response when you do update or delete, should I continue?

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

