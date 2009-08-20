get '/' do
  haml :index
end

get '/help' do
  haml "= BlueCloth::new(File.read 'README.markdown').to_html"
end

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

post '/albums/:name' do
  @album = Album.new(:name => params[:name])
  unless @album.save
    status 500
    return "Could not store"
  end
end

delete '/albums/:name' do
  @album = Album.get(params[:name])
  if @album
    unless @album.destroy
      status 500
      return "Could not delete"
    end
  else
    status 404
    return "No such album"
  end
end
