module BadgevilleBerlin::Shell
  class Core
    
    class << self
      attr_accessor 'sites', 'working_path_parts', 'cache'
    end
    
    self.sites = []
    self.working_path_parts = {:site => nil, :object => nil, :item => nil}
    self.cache = {:site => nil, :item => nil}
    
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
      site = self.is_site_cached(path_parts[:site])
      if !site
        begin
          site = BadgevilleBerlin::Site.find(path_parts[:site])
          self.cache[:site] = site
        rescue
          return false
        end
      end
      
      # Validate Object
      if path_parts[:object] != nil && !Core.objects[path_parts[:object]]
         return false
      end
      
      # Validate item
      if path_parts[:item] != nil && !self.is_item_cached(path_parts[:item])
        begin
          item = Core.objects[path_parts[:object]].find(path_parts[:item]) # currently only works for id
          self.cache[:item] = item
        rescue
          return false
        end
      end
      
      return true
    end
    
    def self.is_site_cached (site)
      if self.cache[:site] == nil
        return false
      end
      return (self.cache[:site].attributes[:url] == site || self.cache[:site].attributes[:_id] == site) ? self.cache[:site] : false
    end
    
    def self.is_item_cached (item)
      if self.cache[:item] == nil
        return false
      end
      return (cache[:item].attributes[:email] == item || cache[:item].attributes[:_id] == item) ? cache[:item] : false
    end
    
  end
end