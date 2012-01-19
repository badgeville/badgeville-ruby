module Badgeville

  class Config < BaseResource
    class << self

      # This class method configures the BaseResource members: format,
      # site and prefix
      #
      # @param [Hash] options the options hash which holds values for the keys `:api_key` and `:site`
      def conf ( options = {} )

        BaseResource.format = :badgeville_json
        p options[:site].class
        if options[:site].empty?
          raise ArgumentError.new("Please enter the URL for the Badgeville site where you want to make your request (e.g.).")
        else
          BaseResource.site = options[:site]
        end

        if options[:api_key].empty?
          raise ArgumentError.new("Please enter a Badgeville API Key.")
        else
          @api_key = options[:api_key]
        end


        # set a path that goes between the URL and the resource
        BaseResource.prefix = "/api/berlin/#@api_key/"
      end

    end
  end
end