module GameManager
  
  module_function
  
  def scene
    @scene
  end
  
  def scene=(scene)
    @scene.terminate if @scene
    @scene = scene
  end
  
  def update
    @scene.update
  end
end