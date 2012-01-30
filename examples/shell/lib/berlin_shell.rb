require 'rubygems'
require 'ruby-debug'
require 'badgeville-berlin'
require 'highline/import'

require_relative 'berlin_shell/core.rb'
require_relative 'berlin_shell/ls.rb'
require_relative 'berlin_shell/cd.rb'
require_relative 'berlin_shell/prompt.rb'

module BadgevilleBerlin
end

module BadgevilleBerlin::Shell
   
  # Handle connection/config
  if ARGV.length < 2
    abort 'Missing host or key.'
  end
  
  begin
    connected = BadgevilleBerlin::Config.conf(:host_name => 'http://' + ARGV[0] + '/', :api_key => ARGV[1])
    Core.sites = BadgevilleBerlin::Site.find(:all)
  rescue
    abort 'Connection failed, verify host or key.'
  end
  
  say 'Connected!'
  
  # Wait for a command
  while Prompt.listen
  end
  
end