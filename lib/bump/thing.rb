module Bump
  # A thing is anything that can be used in the bump system as a 
  # colliding object.
  module Thing
    # position of the center of the object
    attr_reader :p
    # width of the bounding box of object
    attr_reader :w
    # height of the bounding box of object
    attr_reader :h
    
    def initialize(opt={})
      @p = Bump.vec(opt[:px] || 0, opt[:py] || 0)
      @w = opt[:w].to_i || 1
      @h = opt[:h].to_i || 1
    end
   
    # x coordinate of the left of the thing's bounding box
    def x
      (@p.x - (@w/2)).to_i
    end
    
    # y coordinate of the top of the thing's bounding box
    def y
      (@p.y - (@h/2)).to_i
    end
    
      # x coordinate of mobile's center
    def px
      return self.p.x
    end
    
    # y coordinate of mobile's center
    def py
      return self.p.y
    end

    
  end
end