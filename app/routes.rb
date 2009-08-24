require 'rubygems'
require 'haml'
require 'bluecloth'

require 'models'

class Server
    
  before do
    session[:locale] = params[:locale] if params[:locale]
  end
  
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
      @albums = Album.all
      unless @analysis.album
        @analysis.album = @albums[0]
        @analysis.save
      end
      if @analysis.album # we still might have no album at all
        @current_album = @analysis.album
        @reports = @current_album.reports
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
  
  get '/analysis/:analysis/album/:album' do
    @analysis = Analysis.get(params[:analysis])
    if @analysis
      @album = Album.get(params[:album])
      if @album
        @analysis.album = @album
        @analysis.save
        redirect back
      else
        status 500
        return "Could not find album \##{params[:album]}"
      end
    else
      status 500
      return "Could not find analysis \#{params[:analysis]}"
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

end