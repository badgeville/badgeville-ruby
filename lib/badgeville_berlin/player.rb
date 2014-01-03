# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class Player < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = [:custom, :preferences]

    # Enables revising Berlin JSON response key names to match what
    # is expected by model-level logic. (e.g. Berlin JSON payload 
    # returns the player's nickname under the key :nick_name, but the
    # Player model expects it as :nickname without the underscore.)
    CUSTOM_REQUEST_KEYS = {:nick_name => :nickname}
  end
end