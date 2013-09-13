# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class ActivityDefinition < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = :selector, :adjustment
  end
end