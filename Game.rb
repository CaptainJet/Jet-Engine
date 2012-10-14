require 'gosu'
require 'zlib'
require 'texplay'
require 'yaml'
require 'base64'
require 'open-uri'
require 'net/https'

include Gosu

Dir["src/**/*.rb"].cycle(1) {|a| require_relative(a) }

class GosuGame < Window
  
  def initialize(width = Function::CONFIG[:Width], height = Function::CONFIG[:Height], fullscreen = Function::CONFIG[:Fullscreen])
    super(width, height, fullscreen)
    self.caption = Function::CONFIG[:Title]
    Tasks.new_task_loop(60) { Audio.se_update }
  end
  
  def update
    Tasks.update
    Input.update
    GameManager.update
    update_fps
  end
  
  def draw
    Graphics.update
  end
  
  def update_fps
    self.caption = Function::CONFIG[:Title] + " (#{Gosu.fps} FPS)"
  end
  
  def button_down(id)
    Input.add_key(id)
  end
end

Graphics.gosu_window = GosuGame.new
GameManager.scene = Scene_Test.new
Graphics.gosu_window.show