module BadgevilleBerlin::Shell
  class Prompt
    def self.listen
      instructions = ask(Core.working_path + " >> " ).split(" ", 2)

      if instructions.empty?
        return true
      end

      case instructions[0].downcase
        when 'exit'
          say 'Goodbye!'
          return false
          
        when 'ls'
          begin
            LS.execute(instructions[1])
          rescue
            say('ls failed')
          end
          
        when 'cd'
          CD.execute(instructions[1])
          
        when 'rm'
          Commands.rm(instructions[1])
          
        when 'touch'
          Commands.touch(instructions[1])
          
        when "pwd"
          Commands.pwd
        else
      end
      
      return true
    end
  end
end