module FileManager

  module_function
  
  PATCH_DIRECTORY = File.join(ENV['APPDATA'], "RubyGame")
  
  FileUtils.mkdir_p(PATCH_DIRECTORY)
  
  @files = []
  
  def check_for_updates
    compare_manifest
    download_files
  end
  
  def compare_manifest
    file = File.join(PATCH_DIRECTORY, "Manifest.yml")
    @current_manifest = YAML.load_file(File.join("data", "Manifest.yml"))
    Function.download_file(file, "https://dl.dropbox.com/u/35988679/RubyGame/data/Manifest.yml")
    @newest_manifest = YAML.load_file(File.join(PATCH_DIRECTORY, "Manifest.yml"))
    @newest_manifest.each {|a, b|
      if !current_manifest.has_key?(a) || current_manifest[a] < b
        @files << a
      end
    }
  end
  
  def download_files
    @files.each {|a|
      Function.download_file(a, "https://dl.dropbox.com/u/35988679/RubyGame/#{a}") rescue next
      @current_manifest[a] = @newest_manifest[a]
      File.open("data/Manifest.yml", "w+") {|a| a.write @current_manifest.to_yaml }
    }
  end
end