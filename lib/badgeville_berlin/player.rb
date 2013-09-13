# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class Player < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = [:custom]
  end
end