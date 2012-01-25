require "rubygems"
require "ruby-debug"
require "badgeville-berlin"
require "highline/import"


module BadgevilleBerlin

  HOST = "staging.badgeville.com"
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"

  Config.conf(:site => 'http://' + HOST + '/', :api_key => APIKEY)
  say("Connected!")
  
  @@bv_objs = {
    "Activity" => Activity,
    "ActivityDefinition" => ActivityDefinition,
    "Group" => Group,
    "Leaderboard" => Leaderboard,
    "Player" => Player,
    "Reward" => Reward,
    "RewardDefinition" => RewardDefinition,
    "Site" => Site,
    "Track" => Track,
    "User" => User
  }
  
  def self.bv_objs
    @@bv_objs
  end
  
  def self.parse_path (path)
    path.split("/")
  end
  
  class Commands
    def self.ls (path)
      if (path == nil)
        @str = BadgevilleBerlin.bv_objs.keys.join("     ")
      end
      path_parts = BadgevilleBerlin.parse_path(path)
      say(@str)
    end
    
    def self.cd (path)
      if (path == nil)
          say ("Missing argument")
      end
      
      path_parts = BadgevilleBerlin.parse_path(path)
      if ()
      #check if path is valid
    end
    
    def touch 
    
    end
    
    def rm
    end
    
  end
  
  cwd = nil # Site/Object/ID
  while true
    inputs = ask("BadgevilleBerlin >> ").split(" ")
  
    case inputs[0].downcase
    when "exit"
      abort("Goodbye!")
    when "ls"
      Commands.ls(inputs[1])
    when "cd"
    else
    end
  end

end