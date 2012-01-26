require "rubygems"
require "ruby-debug"
require "badgeville-berlin"
require "highline/import"


module BerlinShell
  HOST = "staging.badgeville.com"
  APIKEY = "007857cd4fb9f360e120589c34fea080"
  ENDPOINT = "/api/berlin/"
  SPACER = "\n"
  BadgevilleBerlin::Config.conf(:host_name => 'http://' + HOST + '/', :api_key => APIKEY)
  say "Connected to " + HOST
  
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
  @@sites = BadgevilleBerlin::Site.find(:all)
  @@working_path_parts = ["Site"]
  @@item = nil
  
  def self.item
    @@item
  end
  def self.item=(item)
    @@item = item
  end
  
  def self.bv_objs
    @@bv_objs
  end
  
  def self.sites
    @@sites
  end
  
  def self.sites=(sites)
    @@sites = sites
  end
  
  # Site/Object/ID, touch ABC.COM/player/; touch {email: name: etc,}
  def self.working_path_parts
     @@working_path_parts
  end
  def self.working_path_parts=(parts)
    @@working_path_parts = parts
  end
  
  def self.parse_path (path)
    if path == "/"
      path = "/Site"
    end
    
    # Handle ../
    if (path == "../" && BerlinShell.working_path_parts.length > 1)
      BerlinShell.working_path_parts.pop
      path = ""
    end
    
    if !path.match /^\// # Relative Path
      path = BerlinShell.working_path_parts.join("/") + "/" + path
    elsif !path.match /^\/Site/ # Absolute Path w.out /Site
      path = "/Site" + path
    end
    
    path = path.sub(/^\/*/,"").sub(/\/$/,"") # Trim / 
    parts = path.split("/")
    
    parts
  end

  def self.find_prefix (prefix, list)
    found = false
    list.each do |item|
      if item.id
        if item.id.match /^ + prefix + /
          return item
        end
      end
    end
  end
  
  def self.valid_path_parts (parts)
    if parts.length == 1
      return true
    end
    
    # Validate site
    if !get_site(parts[1])
      return false
    end
    
    # Validate Object
    if parts[2] && !BerlinShell.bv_objs[parts[2]]
       return false
    end
    
    # Validate item
    if parts[3]
      # needs to be coded
    end
    
    return true
  end
  
  def self.get_site (needle)
    found = false
    BerlinShell.sites.each do |site|
      if site.name == needle || site.id == needle
        found = site
      end
    end
    return found
  end

  
  class Commands
    def self.ls (path)
      path_parts = (path == nil) ? BerlinShell.working_path_parts : BerlinShell.parse_path(path)
      items = []
      if !BerlinShell.valid_path_parts(path_parts)
        say "Path is not valid."
        return
      end
      case  path_parts.length
        when 1 # List Sites
          BerlinShell.sites = BadgevilleBerlin::Site.find(:all)
          BerlinShell.sites.each do |site|
            items.push(site.id + " (" + site.name + ")")
          end
        when 2 # List Objects
          BerlinShell.bv_objs.each do |name, obj|
            items.push(name)
          end
        when 3 # List Items
          BerlinShell.bv_objs[path_parts[2]].find(:all).each do |item|
            # Use ID, but try to add email then name if available
            items.push((item.attributes["_id"] || item.attributes["id"]) + (item.attributes["email"] ? " (" + item.attributes["email"] + ")" : (item.attributes["name"] ? " (" + item.attributes["name"] + ")" : "") ))
          end
        when 4 # List Details
          items.push(BerlinShell.bv_objs[path_parts[2]].find(path_parts[3]).to_yaml)
      end
      
      say items.join(SPACER)
    end
    
    def self.cd (path)
      if (path == nil)
          say ("Missing argument.")
      end
      path_parts = BerlinShell.parse_path(path)
      if BerlinShell.valid_path_parts(path_parts)
        BerlinShell.working_path_parts = path_parts
      else
        say "Path is not valid."
      end
    end
    
    def self.touch 
    
    end
    
    def self.rm
    end
  end

  while true
    inputs = ask(@@working_path_parts.join("/") +  "/ >> " ).split(" ", 2)
  
    case inputs[0].downcase
    when "exit"
      abort("Goodbye!")
    when "ls"
      Commands.ls(inputs[1])
    when "cd"
      Commands.cd(inputs[1])
    else
    end
  end

end