class Bitmap < Image
  
  LOAD_PATH = "./media/image"
  
  def initialize(filename)
    filename = filename.is_a?(String) ? "#{LOAD_PATH}/#{filename}.png" : filename
    super(Graphics.gosu_window, filename)
  end
  
  def rect
    Rect.new(0, 0, width, height)
  end

  def self.from_blank(width, height)
    Bitmap.new(EmptyImageStub.new(width, height))
  end
end