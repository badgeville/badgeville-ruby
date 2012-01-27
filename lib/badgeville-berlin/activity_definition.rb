# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class ActivityDefinition < BadgevilleBerlin::BaseResource

    # @new_activity_definition.attributes.keys.each do |method_name|
    #   define_method method_name do
    #       self.state = method_name
    #    end
    # end
    def enable_rate_limiting=(args)
      self.attributes[:selector] = self.attributes[:selector].attributes
      self.attributes[:adjustment] = self.attributes[:adjustment].attributes
      super
    end



  end
end