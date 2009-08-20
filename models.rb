require 'fileutils'

class Resource

  def initialize(type, filename, source)
    if (type == :dir) then
      Dir.mkdir filename
    else
      File.open(filename, "w") { |f| f.write source.read }
    end
  end

  def self.get(filename)
    if File.directory? filename then
      Dir.entries(filename).find_all{|e| e[0] != '.'[0]}.to_json()
    else
      File.open(filename, "r") { |f| f.read }
    end
  end

  def self.delete!(filename)
    if File.directory?(filename) then
      FileUtils.rm_rf filename
    else
      File.delete filename
    end
  end

end