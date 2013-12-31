# Subclasses BaseResource to represent a remote resource model class.
module BadgevilleBerlin
  class Player < BadgevilleBerlin::BaseResource
    COMPLEX_ATTRIBUTES = [:custom, :preferences]

    # Enables revising Berlin JSON response key names to match what
    # is expected by model-level logic. (e.g. Berlin JSON payload 
    # returns the player's nickname under the key :nick_name, but the
    # Player model expects it as :nickname without the underscore.)
    CUSTOM_REQUEST_KEYS = {:nick_name => :nickname}

    # Analogous to aliasing nick_name= setter. Therefore even if the
    # Berlin JSON payload for Player returns the player's nickname 
    # under the key :nick_name, the gem user can still set  
    # the attribute using @player.nickname=  without the underscore.) 
    def nickname=(arg)
      self.nick_name = arg
    end

    # Analogous to aliasing nick_name getter. Therefore even if the
    # Berlin JSON payload for Player returns the player's nickname 
    # under the key :nick_name, the gem user can still retrieve  
    # the attribute using @player.nickname (without the underscore.) 
    def nickname
      self.nick_name
    end

  end
end