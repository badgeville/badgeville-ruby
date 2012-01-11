#********** ADDING module CustomFormat **********#
# Handles the fact that a JSON formatted GET response does not meet the
# ActiveResource standard, and is instead preceded by the root key :data
module BadgevilleJsonFormat
  extend self

  def extension
    "json"
  end

  def mime_type
    "application/json"
  end

  def encode(hash, options = nil)
    ActiveSupport::JSON.encode(hash, options)
  end

  def decode(json)
    ActiveResource::Formats.remove_root(ActiveSupport::JSON.decode(json))["data"] || ActiveResource::Formats.remove_root(ActiveSupport::JSON.decode(json))
  end
end