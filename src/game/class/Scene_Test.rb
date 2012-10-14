class Scene_Test < Scene
  
  def initialize
    @sprite = Player.new {|a| a.bitmap = Bitmap.new("Arrow"); a.register }
  end
  
  def update
    @sprite.update
  end
end