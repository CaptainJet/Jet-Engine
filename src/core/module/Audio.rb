module Audio

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
    Thread.new {
      incs = @bgm_volume / time
      until @bgm_volume <= 0
        @bgm_volume -= incs
        @bgm.volume -= incs
        sleep 0.01
      end
      bgm_stop
    }
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
    Thread.new {
      incs = @bgs_volume / time
      until @bgs_volume <= 0
        @bgs_volume -= incs
        @bgs.volume -= incs
        sleep 0.01
      end
      bgs_stop
    }
  end

  def se_play(filename, volume = 100)
    filename = File.join(LOAD_PATH, "se", filename) + ".ogg"
    @se = [] if @se == nil
    @se << Sample.new(Graphics.gosu_window, filename).play(volume / 100.0, pitch / 100.0, false)
  end
  
  def se_stop
    @se = [] if @se == nil
    @se.cycle(1) {|a| a.stop }
    @se.clear
  end
  
  def se_update
    @se = [] if @se == nil
    @se.collect! {|a| a.playing? }
  end
end