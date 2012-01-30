module BadgevilleBerlin


  # Subclasses ActiveResource::Base as BaseResource
  class BaseResource < ActiveResource::Base


    class << self
      # Overrides the ActiveResource class method primary_key to be '_id'
      # instead of 'id.'
      #
      # @return [String] primary key name '_id'
      def primary_key
        @primary_key = '_id'
      end
    end

    # Overrides encode call to prevent to_json from converting non-valid type
    # objects to nested-json hash (e.g. BadgevilleBerlin::ActivityDefinition::Selector)
    # to allow for 200 OK response on PUT
    def encode(options={})
      sanitize_request
      send("to_#{self.class.format.extension}", options)
    end

    def sanitize_request
      valid_types = ["String", "Fixnum", "NilClass", "TrueClass", "FalseClass"]
      self.attributes.values.each_with_index do |k,index|
        if !valid_types.include?(self.attributes[self.attributes.keys[index]].class.to_s)
          self.attributes[self.attributes.keys[index]] = self.attributes[self.attributes.keys[index]].attributes.to_json
        end
      end
    end

    # Overrides the ActiveResource instance method in module Validations
    # in order to call the BadgevilleBerlin::Errors constructor instead of
    # the ActiveResource::Errors constructor.
    #
    # @return [BadgevilleBerlin::Errors] object that holds information about
    # errors messages from the remote server and mimics the interface of the
    # errors provided by ActiveRecord::Errors.
    def errors
      @errors ||= BadgevilleBerlin::Errors.new(self)
    end

    # Overrides the ActiveResource isntance method in module Validations
    # in order to load_remote_errors() for the case where the format is
    # the custom BadgevilleJson format. Loads the set of remote errors into
    # the object’s Errors collection based on the content-type of the
    # error-block received.
    #
    # @param remote_errors errors from teh remote server
    # @param [Object] save_cache flag that directs the errors cache to be
    # cleared by default
    def load_remote_errors(remote_errors, save_cache = false ) #:nodoc:
      case self.class.format
      when ActiveResource::Formats[:xml]
        errors.from_xml(remote_errors.response.body, save_cache)
      when ActiveResource::Formats[:json]
        errors.from_json(remote_errors.response.body, save_cache)
      when ActiveResource::Formats[:badgeville_berlin_json]
          errors.from_badgeville_berlin_json(remote_errors.response.body, save_cache)
      end
    end

  end

end