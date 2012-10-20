class Rect
  
  attr_accessor :x, :y, :width, :height
  
  def initialize(x, y, width, height)
    set(x, y, width, height)
  end
  
  def set(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end
  
  def intersects?(rect)
		return ((((rect.x < (self.x + self.width)) && (self.x < (rect.x + rect.width))) && (rect.y < (self.y + self.height))) && (self.y < (rect.y + rect.height)))
	end
  
  def to_a
    [x, y, width, height]
  end
end