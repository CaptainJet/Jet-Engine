module Graphics

  class << self
    
    attr_accessor :gosu_window
    attr_reader :brightness
    
    def brightness=(int)
      @brightness = [[255, int].min, 0].max
      @draw_color.alpha = 255 - @brightness
    end
  end
  
  @brightness = 255
  @draw_color = Color::BLACK
  @draw_color.saturation = 0
  @draw_color.alpha = 0
  @@gosu_sprites = []

  module_function
  
  def update
    @@gosu_sprites.each {|sprite|
      sprite.draw
    }
    if @draw_color.alpha != 0
      c = @draw_color
      args = [0, 0, c, 0, height, c, width, 0, c, width, height, c, 1]
      Graphics.gosu_window.draw_quad(*args)
    end
  end
  
  def fadeout(duration)
  end
  
  def fadein(duration)
  end
  
  def width
    gosu_window.width
  end
  
  def height
    gosu_window.height
  end
  
  def add_sprite(sprite)
    @@gosu_sprites << sprite
  end
  
  def remove_sprite(sprite)
    @@gosu_sprites.delete(sprite)
  end
  
  def fullscreen?
    gosu_window.fullscreen?
  end
end