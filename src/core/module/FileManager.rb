module FileManager

  module_function
  
  PATCH_DIRECTORY = File.join(ENV['APPDATA'], "RubyGame")
  
  FileUtils.mkdir_p(PATCH_DIRECTORY)
  
end