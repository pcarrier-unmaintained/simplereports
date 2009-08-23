get '/' do
  @analysis = Analysis.new
  if @analysis.save
    redirect "/analysis/#{@analysis.id}/view.html"
  else
    status 500
    return "Could not create analysis"
  end
end

get '/analysis/:id/:action.html' do
  @analysis = Analysis.get(params[:id])
  if @analysis
    @albums = Album.get(:all)
    if @analysis.album
      @reports = @analysis.album.reports
    end
    @analyzed = @analysis.reports
    case params[:action]
    when 'albums'
      haml :albums, :layout => false
    when 'reports'
      haml :reports, :layout => false
    when 'analyzed'
      haml :'analysis/list', :layout => false
    else
      haml :'analysis/view'
    end
  else
    status 500
    return "Could not find analysis"
  end
end

get '/help' do
  haml "= BlueCloth::new(File.read 'README.markdown').to_html"
end

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

post '/albums' do
  @album = Album.new(:name => params[:name])
  if @album.save
    redirect back
  else
    status 500
    return "Could not store"
  end
end

delete '/albums/:name' do
  @album = Album.get(params[:name])
  if @album
    if @album.destroy
      redirect back
    else
      status 500
      return "Could not delete"
    end
  else
    status 404
    return "No such album"
  end
end
