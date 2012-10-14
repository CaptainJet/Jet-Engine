module GameManager

  class << self
    
    attr_reader :scene
    
  end
  
  module_function
  
  def scene=(scene)
    @scene.terminate if @scene
    @scene = scene
  end
  
  def update
    @scene.update
  end
end