module Badgeville

  class Config < BaseResource
    class << self

      # This class method configures the BaseResource members: format,
      # site and prefix
      #
      # @param [Hash] options the options hash which holds values for the keys `:api_key` and `:site`
      def conf ( options = {} )
        BaseResource.format = :badgeville_json
        BaseResource.site = options[:site]    if options[:site]
        @api_key = options[:api_key]          if options[:api_key]

        # set a path that goes between the URL and the resource
        BaseResource.prefix = "/api/berlin/#@api_key/"
      end

    end
  end
end