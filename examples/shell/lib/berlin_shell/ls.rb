module BadgevilleBerlin::Shell
  class LS
    @@spacer = "\n"
    
    def self.execute (path)
      path_parts = (path == nil) ? Core.working_path_parts : Core.parse_path(path)
      
      if !Core.valid_path_parts(path_parts)
        say "Path is not valid."
        return
      end
      
      if path_parts[:site] == nil
        items = self.get_sites
      elsif path_parts[:object] == nil
        items = self.get_objects
      elsif path_parts[:item] == nil
        items = self.get_items(path_parts)
      else
        items = self.get_details
      end

      say items.join(@@spacer)
    end
    
    def self.get_sites
      items = []
      page = 1
      while true
        sites = BadgevilleBerlin::Site.find(:all, :params => {:page => page, :per_page => 50})
        if sites.empty?
          break
        else
          sites.each do |site|
            Core.sites.push(site)
          end
          page = page + 1
        end
      end
      Core.sites.each do |site|
        items.push(site.id + " (" + site.url + ")")
      end
      
      return items
    end
    
    def self.get_objects ()
      items = []
      Core.objects.each do |name, obj|
        items.push(name)
      end
      return items
    end
    
    def self.get_items (path_parts)
      items = []
      params = {}
      params[:site] = path_parts[:site]
      Core.objects[path_parts[:object]].find(:all, params).each do |item|
        # Use ID, but try to add email then name if available
        items.push((item.attributes["_id"] || item.attributes["id"]) + (item.attributes["email"] ? " (" + item.attributes["email"] + ")" : (item.attributes["name"] ? " (" + item.attributes["name"] + ")" : "") ))
      end
      return items
    end
    
    def self.get_details (path_parts)
      items = []
      items.push(Core.objects[path_parts[:object]].find(path_parts[:item]).to_yaml)
      return items
    end
  end
end