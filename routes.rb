helpers do
  def project_name
    options.pdescr
  end
  def ressource_path(name)
    File.join(options.pstore, name)
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
  Resource.get(ressource_path(params[:splat]))
end

put '/resources/*' do
  begin
    if params[:splat][-1,1] == '/' then
      filename = ressource_path(params[:splat])[0..-2]
      Resource.new(:dir, filename, nil)
    else
      filename = ressource_path(params[:splat])
      Resource.new(:file, filename, params[:file]['file'])
    end
  rescue
    status 500
    return "Could not create resource!"
  end
end

delete '/resources/*/?' do
  begin
    Resource.delete!(ressource_path(params[:splat]))
  rescue
    status 500
    return "Could not remove resource!"
  end
end