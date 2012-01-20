module Badgeville

  # Subclasses ActiveResource::Errors to be used by BaseResource as Badgeville::Errors.
  class Errors < ActiveResource::Errors
    # Grabs errors originating from the remote model class. The custom JSON error
    # response format may not have a root key :errors.
    #
    # @param [String?] json the JSON response data in custom BadgevilleJsonFormat
    # @return [Array] error messages associated with the remote model
    def from_badgeville_json(json, save_cache = false)
      p "HELLO"
      formatted_json_decoded = Array.new
      #debugger
      json_decoded = (ActiveSupport::JSON.decode(json))['errors'] || ActiveSupport::JSON.decode(json) rescue []
       p "This is json_decoded: #{json_decoded}"
      json_decoded.each do |attribute_name, err_msgs|
        if err_msgs.is_a? Array
          p "IS ARRAY"
          err_msgs.each do |err_msg|
            p attribute_name, "IS ATTRIBUTE NAME"
            formatted_json_decoded.push(attribute_name.humanize + " #{err_msg}")
          end
        elsif err_msgs.is_a? String
          p "IS STRING"
          formatted_json_decoded.push(attribute_name, err_msgs)
        else
          p "IS NEITHER"
        end
      end
      from_array formatted_json_decoded, save_cache
    end

  end
end