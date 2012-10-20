require 'gosu'
require 'zlib'
require 'yaml'
require 'base64'
require 'open-uri'
require 'net/https'
require 'fileutils'
require 'profile'

include Gosu

enable_undocumented_retrofication

Dir[File.join(Dir.pwd, 'src', '**',  '*.rb')].each {|file| require file }
files = Dir["**/*.*"]
excluded_files = ["data/Config.yml", "README.txt", "data/Manifest.yml"]
hash = {}
(files - excluded_files).each {|a|
  hash[a] = "1.0.0"
}
File.open("data/Manifest.yml", "w+") {|a| a.write hash.to_yaml }

class GosuGame < Window
  
  def initialize(width = Function::CONFIG[:Width], height = Function::CONFIG[:Height], fullscreen = Function::CONFIG[:Fullscreen])
    super(width, height, fullscreen)
    self.caption = Function::CONFIG[:Title]
    Tasks.new_task_loop(60) { Audio.se_update }
    Thread.new { FileManager.check_for_updates } if Function::CONFIG[:Update]
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