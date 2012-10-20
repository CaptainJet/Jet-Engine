module Function

  module_function
  
  CONFIG = {
    :Title => "Tevak and Jet",
    :Width => 544,
    :Height => 416,
    :Fullscreen => false,
    :Update => false
  }.merge!(YAML.load_file(File.join("data", "Config.yml")))
  
  def load_file(filename)
    name = File.join("data", filename)
    fr = File.open(name, "rb") {|a| Marshal.load(a) }
    fr = Base64.decode64(Zlib::Inflate.inflate(fr))
    fr = Marshal.load(fr)
    fr
  end
  
  def save_file(obj, filename)
    name = File.join("data", filename)
    ar = Marshal.dump(obj)
    ar = Base64.encode64(ar)
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
  
  def download_file(filename, url, opt={}, &block)
    opt = {
      :init_pause => 0.1,
      :learn_period => 0.3,
      :drop_factor => 1.5,
      :adjust => 1.05 
    }.merge(opt)
    pause = opt[:init_pause]
    learn = 1 + (opt[:learn_period]/pause).to_i
    drop_period = true
    delta = 0
    max_delta = 0
    last_pos = 0
    File.open(filename,'wb'){ |f|
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
        response = http.request_head(uri.path)
        file_size = response['content-length']
        http.request_get(uri.path){ |res|
          res.read_body{ |seg|
            f << seg
            delta = f.pos - last_pos
            last_pos += delta
            if delta > max_delta then max_delta = delta end
            if learn <= 0 then
              learn -= 1
            elsif delta == max_delta then
              if drop_period then
                pause /= opt[:drop_factor]
              else
                pause /= opt[:adjust]
              end
            elsif delta < max_delta then
              drop_period = false
              pause *= opt[:adjust]
            end
            block.call(file_size, f.size) if block_given?
            sleep(pause)
          }
        }
      }
    }
  end
end