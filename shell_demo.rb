require "rubygems"
require "ruby-debug"
require "badgeville-berlin"
require "highline/import"


module BadgevilleBerlin

  HOST = "staging.badgeville.com"
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"
  
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
  
  @@working_path_parts = []
  
  def self.bv_objs
    @@bv_objs
  end
  
  def self.working_path_parts
     @@working_path_parts
  end
  
  def self.parse_path (path)
    path.split("/")
  end
  
  def self.valid_path_parts (parts)
     #check if path is valid
      Config.conf(:site => 'http://' + path_parts[0] + '/', :api_key => APIKEY)
    true
  end
  
  class Commands
    def self.ls (path)
      path_parts = (path == nil) ? BadgevilleBerlin.working_path_parts : BadgevilleBerlin.parse_path(path)
      
      say(@str)
    end
    
    def self.cd (path)
      if (path == nil)
          say ("Missing argument.")
      end
      path_parts = BadgevilleBerlin.parse_path(path)
      if BadgevilleBerlin.valid_path_parts(path_parts)
        BadgevilleBerlin.working_path_parts = path_parts
      else
        say ("Path is not valid.")
      end
    end
    
    def self.touch 
    
    end
    
    def self.rm
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