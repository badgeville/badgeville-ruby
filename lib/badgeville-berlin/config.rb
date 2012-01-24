module BadgevilleBerlin

  class Config < BaseResource
    class << self

      # This class method configures the BaseResource members: format,
      # site and prefix
      #
      # @param [Hash] options the options hash which holds values for the keys `:api_key` and `:site`
      def conf ( options = {} )

        BaseResource.format = :badgeville_berlin_json

        if options[:site] == nil || options[:site].empty?
            raise ArgumentError.new("Please enter the URL for the Badgeville site where you want to make your request ( e.g. :site  => 'http://staging.badgeville-berlin.com' ).")
        else
          BaseResource.site = options[:site]
          if options[:site].split("://")[1] == nil
            raise ArgumentError.new("Please include the scheme for the request site ( e.g. http:// ).")
          end
        end

        if options[:api_key] == nil || options[:api_key].empty?
          raise ArgumentError.new("Please enter a Badgeville API Key ( e.g. :api_key  => '[your Badgeville API Key]' ).")
        else
          @api_key = options[:api_key]
        end


        # set a path that goes between the URL and the resource
        BaseResource.prefix = "/api/berlin/#@api_key/"
      end

    end
  end
end