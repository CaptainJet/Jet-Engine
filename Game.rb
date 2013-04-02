require 'gosu'
require 'zlib'
require 'yaml'
require 'fileutils'
require 'profile'

include Gosu

enable_undocumented_retrofication

Dir[File.join(Dir.pwd, 'src', '**',  '*.{rb,so}')].each {|file| require file }

class GosuGame < Window
  
  def initialize(width = Function::CONFIG[:Width], height = Function::CONFIG[:Height], fullscreen = Function::CONFIG[:Fullscreen])
    super(width, height, fullscreen)
    self.caption = Function::CONFIG[:Title]
    Tasks.new_task_loop(60) { Audio.se_update }
  end
  
  def update
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