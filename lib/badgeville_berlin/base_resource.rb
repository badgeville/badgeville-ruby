module BadgevilleBerlin


  # Subclasses ActiveResource::Base as BaseResource
  class BaseResource < ActiveResource::Base

    COMPLEX_ATTRIBUTES = []

    def initialize(attributes = {}, persisted = false)
      #we return a nested JSON response with player rewards keyed off of mongo id's
      #on groups endpoint which causes activeresource to break when looking up a
      #physical id as an attribute on an activeresource model. fix:
      attributes["rewards"] = attributes["rewards"].try(:values) if self.class.to_s == "BadgevilleBerlin::Group"
      super
    end

    def load(attributes, remove_root = false)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)

      if attributes.keys.size == 1
        remove_root = self.class.element_name == attributes.keys.first.to_s
      end

      attributes = ActiveResource::Formats.remove_root(attributes) if remove_root

      customize_keys_for_request(attributes).each do |key, value|
        @attributes[key.to_s] =
            case value
              when Array
                resource = nil
                value.map do |attrs|
                  if attrs.is_a?(Hash)
                    resource ||= find_or_create_resource_for_collection(key)
                    resource.new(attrs)
                  else
                    attrs.duplicable? ? attrs.dup : attrs
                  end
                end
              when Hash
                if self.class::COMPLEX_ATTRIBUTES.include?(key)
                  #if the key is selector or adjustment, as on the ActivityDefinition object, we don't want to create a nested resource
                  value
                else
                  resource = find_or_create_resource_for(key)
                  resource.new(value)
                end
              else
                value.duplicable? ? value.dup : value
            end
      end
      self
    end

    # Enables revising Berlin JSON response key names to match what
    # is expected by model-level logic. (e.g. Berlin JSON payload
    # returns the player's nickname under the key :nick_name, but the
    # Player model expects it as :nickname without the underscore.)
    #
    # @example Rewrites the BadgevilleBerlin::Player :nick_name key as 
    # :nickname.
    def customize_keys_for_request(attrs)
      # The given resource type determined by self.class. For each attribute key
      # in the ActiveResource object that needs renaming, replace the original
      # hash key with the revised hash key as specified in the resource type
      # -specific constant CUSTOM_ATTRS_FOR_REQUEST.
      if defined?(self.class::CUSTOM_REQUEST_KEYS)
        self.class::CUSTOM_REQUEST_KEYS.each do |orig_key, revised_key| 
          attrs[revised_key] = attrs.delete(orig_key) if attrs.include?(orig_key) 
        end
      end
      attrs
    end


    # Overrides encode call to prevent to_json from converting non-valid type
    # objects to nested-json hash (e.g. BadgevilleBerlin::ActivityDefinition::Selector)
    # to allow for 200 OK response on PUT
    def encode(options={})
      sanitize_request
      send("to_#{self.class.format.extension}", options)
    end

    def sanitize_request
      valid_types = ["String", "Fixnum", "NilClass", "TrueClass", "FalseClass", "ActiveSupport::HashWithIndifferentAccess", "Float", "Array"]
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

    # Overrides the ActiveResource instance method in module Validations
    # in order to load_remote_errors() for the case where the format is
    # the custom BadgevilleJson format. Loads the set of remote errors into
    # the object’s Errors collection based on the content-type of the
    # error-block received.
    #
    # @param remote_errors errors from the remote server
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