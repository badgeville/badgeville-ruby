module Badgeville


  # SUBCLASSING ActiveResource::Base as BaseResource
  class BaseResource < ActiveResource::Base

    # CLASS METHODS
    # OVERRIDING ActiveResource attribute
    class << self
      def primary_key
        @primary_key = '_id'
      end

      def config ( options = {} )
        self.format = :badgeville_json
        self.site = options[:site]    if options[:site]
        @api_key = options[:api_key]  if options[:api_key]

        # set a path that goes between the URL and the resource
        self.prefix = "/api/berlin/#@api_key/"
      end

    end

    # OVERRIDING ActiveResource method in module Validations in order to
    # call the Badgeville.Errors constructor instead of the
    # ActiveResource::Errors constructor
    # Returns the Badgeville::Errors object that holds all information about attribute error messages.
    def errors
      @errors ||= Badgeville::Errors.new(self)
    end

    # OVERRIDING ActiveResource method in module Validations in order to
    # load_remote_errors() for the case where the format is the custom
    # BadgevilleJson format
    def load_remote_errors(remote_errors, save_cache = false ) #:nodoc:
      case self.class.format
      when ActiveResource::Formats[:xml]
        errors.from_xml(remote_errors.response.body, save_cache)
      when ActiveResource::Formats[:json]
        errors.from_json(remote_errors.response.body, save_cache)
      when ActiveResource::Formats[:badgeville_json]
          errors.from_badgeville_json(remote_errors.response.body, save_cache)
      end
    end

  end

end