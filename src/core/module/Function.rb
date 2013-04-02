module Function

  module_function
  
  CONFIG = {
    :Title => "Jet",
    :Width => 544,
    :Height => 416,
    :Fullscreen => false,
    :Update => false
  }.merge!(YAML.load_file(File.join("data", "Config.yml")))
  
  def load_file(filename)
    name = File.join("data", filename)
    fr = File.open(name, "rb") {|a| Marshal.load(a) }
    fr = Zlib::Inflate.inflate(fr)
    fr = Marshal.load(fr)
    fr
  end
  
  def save_file(obj, filename)
    name = File.join("data", filename)
    ar = Marshal.dump(obj)
    ar = Zlib::Deflate.deflate(ar, 9)
    File.open(name, "wb") {|a| 
      Marshal.dump(ar, a) 
    }
  end
  
  def os
    case RUBY_PLATFORM
    when /cygwin|mswin|mingw|bccwin|wince|emx/i
      :windows
    when /darwin/i
      :mac
    when /linux/i
      :linux
    when /java/i
      :android
    else
      :unknown
    end
  end
end