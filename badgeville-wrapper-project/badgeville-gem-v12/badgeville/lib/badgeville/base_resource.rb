module Badgeville


  # Subclasses ActiveResource::Base as BaseResource
  class BaseResource < ActiveResource::Base


    class << self
      # This subclass overrides the ActiveResource attribute primary_key
      # to be '_id' instead of 'id.'
      #
      # @return [String] primary key name '_id'
      def primary_key
        @primary_key = '_id'
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