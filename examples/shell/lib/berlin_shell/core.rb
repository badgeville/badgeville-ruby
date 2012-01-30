module BadgevilleBerlin::Shell
  class Core
    
    class << self
      attr_accessor 'sites', 'working_path_parts'
    end
    
    self.sites = []
    self.working_path_parts = []
    
    @@objs = {
      "Activity" => BadgevilleBerlin::Activity,
      "ActivityDefinition" => BadgevilleBerlin::ActivityDefinition,
      "Group" => BadgevilleBerlin::Group,
      "Leaderboard" => BadgevilleBerlin::Leaderboard,
      "Player" => BadgevilleBerlin::Player,
      "Reward" => BadgevilleBerlin::Reward,
      "RewardDefinition" => BadgevilleBerlin::RewardDefinition,
      "Track" => BadgevilleBerlin::Track,
      "User" => BadgevilleBerlin::User
    }
    
    def self.objs
      @@objs
    end
    
    def self.parse_path (path)
      if !path.match /^\// # Relative Path
        path = BerlinShell.working_path_parts.join("/") + "/" + path
      end
      path = path.sub(/^\/*/,"").sub(/\/$/,"") # Trim / 
      parts = path.split("/")
      
      # Handle ../../
      parts_clean = []
      parts.each_index do |i|
        if parts[i] == '..'
          parts_clean.delete_at(parts_clean.length - 1)
        elsif parts[i] != '.'
          parts_clean.push(parts[i])
        end
      end
      
      return parts_clean
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
      if parts[2] && !Core.objs[parts[2]]
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
      Core.sites.each do |site|
        if site.url == needle || site.id == needle
          found = site
        end
      end
      return found
    end
    
  end
end