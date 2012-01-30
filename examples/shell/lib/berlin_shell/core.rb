module BadgevilleBerlin::Shell
  class Core
    
    class << self
      attr_accessor 'sites', 'working_path_parts'
    end
    
    self.sites = []
    self.working_path_parts = {:site => nil, :object => nil, :item => nil}
    
    @@objects = {
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
    
    def self.objects
      @@objects
    end
    
    def self.working_path
      path = "/"
      [:site, :object, :item].each do |index|
        if Core.working_path_parts[index] != nil
          path += Core.working_path_parts[index] + "/"
        end
      end
      
      return path
    end
    
    def self.parse_path (path)
      if !path.match /^\// # Relative Path
        path = Core.working_path + path
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
      
      return {:site => parts_clean[0], :object => parts_clean[1], :item => parts_clean[2]}
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

    def self.valid_path_parts (path_parts)
      if path_parts[:site] == nil
        return true
      end
      # Validate site
      if !get_site(path_parts[:site] )
        return false
      end
      # Validate Object
      if path_parts[:object] != nil && !Core.objects[path_parts[:object]]
         return false
      end
      # Validate item
      if path_parts[:item] != nil 
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