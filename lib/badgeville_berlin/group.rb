# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class Group < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = [:adjustment]
  end
end