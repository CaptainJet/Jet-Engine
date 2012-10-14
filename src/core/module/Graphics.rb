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
    @@gosu_sprites.cycle(1) {|sprite|
      sprite.draw
    }
    if @draw_color.alpha != 0
      c = @draw_color
      args = [0, 0, c, 0, height, c, width, 0, c, width, height, c, 1]
      Graphics.gosu_window.draw_quad(*args)
    end
  end
  
  def fadeout(duration)
    Thread.new {
      rate = @brightness / duration.to_f
      until @brightness <= 0
        self.brightness -= rate
        sleep 1.0 / frame_rate
      end
      self.brightness = 0
    }
  end
  
  def fadein(duration)
    Thread.new { 
      rate = 255 / duration.to_f
      until @brightness >= 255
        self.brightness += rate
        sleep 1.0 / frame_rate
      end
      self.brightness = 255
    }
  end
  
  def width
    gosu_window.width
  end
  
  def height
    gosu_window.height
  end
  
  def resize_screen(w, h)
    reform_window(w, h, fullscreen?, gosu_window.update_interval)
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
  
  def set_fullscreen(bool)
    return if bool == fullscreen?
    reform_window(width, height, bool, gosu_window.update_interval)
  end
  
  def reform_window(w, h, f, fps)
    Graphics.gosu_window.close
    Graphics.gosu_window = GosuGame.new(w, h, f, fps)
    Graphics.gosu_window.show
  end
end