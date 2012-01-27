# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class ActivityDefinition < BadgevilleBerlin::BaseResource

    # @new_activity_definition.attributes.keys.each do |method_name|
    #   p method_name
      # define_method method_name do
      #     self.state = method_name
      #  end
    # end

    # def name=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def site_id=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def bucket_drain_rate=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def bucket_max_capacity=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def limit_per_player=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def limit_field_scope=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def verb=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def icon=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def tool_tip=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def hide_in_widgets=(args)
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    def enable_rate_limiting=(args)
      self.attributes[:selector] = self.attributes[:selector].attributes
      self.attributes[:adjustment] = self.attributes[:adjustment].attributes
      super
    end
    #
    # def enable_count_limiting
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def enable_site_notification
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def enable_user_notification
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def enable_auto_subscription
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end
    #
    # def description
    #   self.attributes[:selector] = self.attributes[:selector].attributes
    #   self.attributes[:adjustment] = self.attributes[:adjustment].attributes
    #   super
    # end


    # selector"
    # "adjustment"
    # "_id"
  end
end