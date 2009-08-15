require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'
require 'fileutils'

helpers do
  def project_name
    options.pdescr
  end
  def ressource_path(name)
    File.join(options.pstore, name)
  end
  def dir_content(name)
    Dir.entries(name).find_all{|e| e[0] != '.'[0]}
  end
end

get '/' do
  haml :index
end

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

get '/resources/*/?' do
  filename = ressource_path(params[:splat])
  if File.directory? filename
    dir_content(filename).to_json()
  else # file
    File.open(filename, "r") { |f| f.read }
  end
end

put '/resources/*' do # NO /?
  filename = ressource_path(params[:splat])
  if params[:splat][-1] != '/'[0] # file
    begin
      File.open(filename, "w") do |f|
        f.write params[:file]['file'].read
      end
    rescue
      status 500
      return "Could not store the file!"
    end
  else # dir
    begin
      Dir.mkdir filename
    rescue
      status 501
      return "Could not create directory!"
    end
  end
end

delete '/resources/*/?' do
  filename = ressource_path(params[:splat])
  if File.directory?(filename)
    begin
      FileUtils.rm_rf filename
    rescue
      status 500
      return "Could not remove directory!"
    end
  else # file
    begin
      File.delete filename
    rescue
      status 500
      return "Could not remove the file!"
    end
  end
end