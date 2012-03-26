module BadgevilleBerlin::Shell
  class CD
      def self.execute (path)
        if (path == nil)
            say ("Missing argument.")
            return
        end
        path_parts = Core.parse_path(path)
        
        if Core.valid_path_parts(path_parts)
          Core.working_path_parts = path_parts
        else
          say "Path is not valid."
        end
      end
  end
end