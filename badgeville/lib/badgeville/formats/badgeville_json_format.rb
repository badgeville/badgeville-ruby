# For custom BadgevilleJson
require 'active_support/json'
require "badgeville/version"




# Handles the fact that a JSON formatted GET response does not meet the
# ActiveResource standard, and is instead preceded by the root key :data.
module BadgevilleJsonFormat
  extend self

  # Returns the extension 'json' to be added to the HTTP request URL for JSON endpoints.
  #
  # @return [String] the URL extension 'json'
  def extension
    "json"
  end

  # Returns the mime_type.
  #
  # @return [String] the MIME type for JSON
  def mime_type
    "application/json"
  end

  # Identical to ActiveResource::Format::JsonFormat.encode. Returns the
  # serialized string representation of the remote resource in the
  # specified format (i.e. BadgevilleJsonFormat). Options depend on the
  # configured format.
  #
  # @param [Hash] hash the data hash of key-value pairs representing a remote resource to be converted to the specified encoding format.
  # @param options options may be applicable depending on the format.
  # @return [String] representation of the remote resource
  def encode(hash, options = nil)
    ActiveSupport::JSON.encode(hash, options)
  end

  # Converts a serialized string representation of  a remote resource into
  # a Ruby object, whether or not it has a root key :data.
  #
  # @param [String] the serialized string representation of the resource.
  # @return [Object? BaseResource?] returns an object representing a remote resource?
  def decode(json)  
    ActiveResource::Formats.remove_root(ActiveSupport::JSON.decode(json))["data"] || ActiveResource::Formats.remove_root(ActiveSupport::JSON.decode(json))
  end
end
