require 'logger'

module Badgeville

# Instantiate a logger so HTTP request and response information will be
# printed to STDOUT.
BaseResource.logger       = Logger.new(STDOUT)
BaseResource.logger.level = Logger::DEBUG

end