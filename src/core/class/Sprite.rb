class Sprite
  
  attr_reader :opacity
  attr_accessor :x, :y, :z, :zoom_x, :zoom_y
  attr_accessor :bitmap, :visible
  attr_accessor :angle, :mirror, :blend_type
  
  OPAC_COLOR = Color.rgba(255, 0, 0, 255)
  OPAC_COLOR.saturation = 0
  
  BLEND = {0 => :default, 1 => :additive, 2 => :subtractive}
  
  def initialize(&block)
    @visible = true
    @x, @y, @z = 0, 0, 0
    @zoom_x, @zoom_y = 1.0, 1.0
    @angle = 0
    @mirror = false
    @opacity = 255
    @opac_color = OPAC_COLOR.dup
    @blend_type = 0
    block.call(self) if block_given?
  end
  
  def register
    Graphics.add_sprite(self)
  end
  
  def deregister
    Graphics.remove_sprite(self)
  end
  
  def width
    @bitmap.width rescue 0
  end
  
  def height
    @bitmap.height rescue 0
  end
  
  def opacity=(int)
    @opacity = [[int, 255].min, 0].max
    @opac_color.alpha = @opacity
  end
  
  def draw
    return if !@visible || @opacity == 0 || @bitmap == nil
    args = [@x, @y, @z, @angle, 0.0, 0.0, @zoom_x * (@mirror ? -1 : 1), @zoom_y, @opac_color, BLEND[@blend_type]]
    @bitmap.draw_rot(*args)
  end
end