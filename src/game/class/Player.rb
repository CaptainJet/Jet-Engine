class Player < Sprite
  
  def update
    case Input.dir8
    when 2
      self.y += 3
    when 4
      self.x -= 3
    when 6
      self.x += 3
    when 8
      self.y -= 3
    when 1
      self.y += 3
      self.x -= 3
    when 3
      self.y += 3
      self.x += 3
    when 7
      self.y -= 3
      self.x -= 3
    when 9
      self.y -= 3
      self.x += 3
    end
  end
end