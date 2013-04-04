module Audio

  class << self
    
    attr_reader :bgs, :bgm, :se
    
  end

  module_function
  
  LOAD_PATH = File.join(Dir.pwd, 'media', 'audio')
  
  def bgm_play(filename, volume = 100)
    filename = File.join(LOAD_PATH, "bgm", filename) + ".ogg"
    bgm_stop
    @bgm = Song.new(Graphics.gosu_window, filename)
    @bgm.volume = volume / 100.0
    @bgm.play(true)
    @bgm_volume = volume / 100.0
  end
  
  def bgm_stop
    @bgm.stop if @bgm
  end
  
  def bgm_fade(time)
    return unless @bgm
    incs = @bgm_volume / time
    time.times do |i|
      Tasks.new_task(i + 1) { @bgm.volume -= incs if @bgm == Audio.bgm }
    end
  end
  
  def bgs_play(filename, volume = 100, pitch = 100)
    filename = File.join(LOAD_PATH, "bgs", filename) + ".ogg"
    bgs_stop
    @bgs = Sample.new(Graphics.gosu_window, filename).play(volume / 100.0, pitch / 100.0, true)
    @bgs_volume = volume / 100.0
  end
  
  def bgs_stop
    @bgs.stop if @bgs
  end
  
  def bgs_fade(time)
    return unless @bgs
    incs = @bgs_volume / time
    time.times do |i|
      Tasks.new_task(i + 1) { @bgs.volume -= incs if @bgs == Audio.bgs }
    end
  end

  def se_play(filename, volume = 100)
    filename = File.join(LOAD_PATH, "se", filename) + ".ogg"
    @se = [] if @se == nil
    @se << Sample.new(Graphics.gosu_window, filename).play(volume / 100.0, pitch / 100.0, false)
  end
  
  def se_stop
    @se = [] if @se == nil
    @se.each {|a| a.stop }
    @se.clear
  end
  
  def se_update
    @se = [] if @se == nil
    @se.collect! {|a| a.playing? }
  end
end