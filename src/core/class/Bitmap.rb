class EmptyImageSource < Struct.new(:columns, :rows)
  
  def to_blob
    "\0" * columns * rows * 4
  end
end

class Bitmap < Image
  
  LOAD_PATH = File.join(Dir.pwd, 'media', 'image')
  
  attr_reader :rect
  
  def initialize(filename)
    if filename.is_a?(String)
      filename = File.join(LOAD_PATH, filename) + ".png"
    end
    super(Graphics.gosu_window, filename)
    @rect = Rect.new(0, 0, width, height)
  end

  def self.from_blank(width, height)
    Bitmap.new(EmptyImageSource.new(width, height))
  end
end