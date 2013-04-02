module Input

  @keys, @gosu_keys = [], []
  
  module_function
  
  def update
    @keys = @gosu_keys.dup
    @gosu_keys.clear
  end
  
  def dir4
    return 2 if press?(KbDown)
    return 4 if press?(KbLeft)
    return 6 if press?(KbRight)
    return 8 if press?(KbUp)
    0
  end
  
  def dir8
    return 1 if press?(KbDown) && press?(KbLeft)
    return 3 if press?(KbDown) && press?(KbRight)
    return 7 if press?(KbUp) && press?(KbLeft)
    return 9 if press?(KbUp) && press?(KbRight)
    dir4
  end
  
  def add_key(key)
    @gosu_keys << key
  end
  
  def trigger?(key)
    @keys.include?(key)
  end
  
  def press?(key)
    Graphics.gosu_window.button_down?(key)
  end
end