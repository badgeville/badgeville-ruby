require 'logger'

# Instantiate a logger so HTTP requests and response information will be
# printed to STDOUT.
ActiveResource::Base.logger = Logger.new(STDOUT)
ActiveResource::Base.logger.level = Logger::DEBUG