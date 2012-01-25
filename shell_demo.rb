require "rubygems"
require "ruby-debug"
require "badgeville-berlin"
require "highline/import"


module BerlinShell

  HOST = "staging.badgeville.com"
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"
  SPACER = "       "
  BadgevilleBerlin::Config.conf(:site => 'http://' + HOST + '/', :api_key => APIKEY)
  say("Connected to " + HOST)
  
  
  @@bv_objs = {
    "Activity" => BadgevilleBerlin::Activity,
    "ActivityDefinition" => BadgevilleBerlin::ActivityDefinition,
    "Group" => BadgevilleBerlin::Group,
    "Leaderboard" => BadgevilleBerlin::Leaderboard,
    "Player" => BadgevilleBerlin::Player,
    "Reward" => BadgevilleBerlin::Reward,
    "RewardDefinition" => BadgevilleBerlin::RewardDefinition,
    "Site" => BadgevilleBerlin::Site,
    "Track" => BadgevilleBerlin::Track,
    "User" => BadgevilleBerlin::User
  }
  
  @@working_path_parts = []
  
  def self.bv_objs
    @@bv_objs
  end
  
  # Site/Object/ID, touch ABC.COM/player/; touch {email: name: etc,}
  def self.working_path_parts
     @@working_path_parts
  end
  
  def self.parse_path (path)
    path.split("/")
  end
  
  def self.valid_path_parts (parts)
    # Check if path is valid
    Config.conf(:site => 'http://' + path_parts[0] + '/', :api_key => APIKEY)
    true
  end
  
  class Commands
    def self.ls (path)
      path_parts = (path == nil) ? BerlinShell.working_path_parts : BerlinShell.parse_path(path)
      items = []
      if path_parts.length == 0
        # List Sites
        BadgevilleBerlin::Site.find(:all).each do |site|
          items.push(site.id)
        end
      end
      
      say items.join(SPACER)
    end
    
    def self.cd (path)
      if (path == nil)
          say ("Missing argument.")
      end
      debugger
      path_parts = BerlinShell.parse_path(path)
      if BerlinShell.valid_path_parts(path_parts)
        BerlinShell.working_path_parts = path_parts
      else
        say ("Path is not valid.")
      end
    end
    
    def self.touch 
    
    end
    
    def self.rm
    end
  end

  while true
    inputs = ask("BadgevilleBerlin >> ").split(" ", 2)
  
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