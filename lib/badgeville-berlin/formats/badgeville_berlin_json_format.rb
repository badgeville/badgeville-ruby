# For custom BadgevilleBerlinJson
require 'active_support/json'
require "badgeville-berlin/version"




# Handles the fact that a JSON formatted GET response does not meet the
# ActiveResource standard, and is instead preceded by the root key :data.
module BadgevilleBerlinJsonFormat
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
  # specified format (i.e. BadgevilleBerlinJsonFormat). Options depend on the
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
  def decode(json)
    return unless json
    json = ActiveResource::Formats.remove_root(ActiveSupport::JSON.decode(json))
    if json.kind_of?(Array)
      json
    else
      if json.has_key?('data')
        json['data'].empty? ? json : json['data']
      else
        json
      end
    end

  end
end
