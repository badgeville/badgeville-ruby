# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class ActivityDefinition < BadgevilleBerlin::BaseResource

    def bucket_drain_rate=(args)
      store(args)
      super
    end
    #
    def bucket_max_capacity=(args)
      store(args)
      super
    end

    def limit_per_player=(args)
      store(args)
      super
    end

    def limit_field_scope=(args)
      store(args)
      super
    end

    def icon=(args)
      store(args)
      super
    end

    def hide_in_widgets=(args)
      store(args)
      super
    end

    def enable_rate_limiting=(args)
      store(args)
      super
    end
    #
    def enable_count_limiting=(args)
      store(args)
      super
    end

    def enable_site_notification=(args)
      store(args)
      super
    end

    def enable_user_notification=(args)
      store(args)
      super
    end

    def enable_auto_subscription=(args)
      store(args)
      super
    end
    
    def description=(args)
      store(args)
      super
    end

    def store(args)
      klass = self.attributes[:selector].class.to_s
      if klass.include?("Selector") || klass.include?("Adjustment")
        self.attributes[:selector] = self.attributes[:selector].attributes
        self.attributes[:adjustment] = self.attributes[:adjustment].attributes
      end
    end
  end
end