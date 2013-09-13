# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class Leaderboard < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = [:selector]
  end
end