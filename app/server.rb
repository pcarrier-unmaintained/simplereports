require 'rubygems'
require 'rack'
require 'sinatra/base'
require 'sinatra/r18n'

require 'identitymap'

class Server < ::Sinatra::Base
  use ::Dickpunch::IdentityMap
  register ::Sinatra::R18n
  
  configure do
    disable :run
    enable :sessions
    set :pname => 'SimpleReports',
        :pversion => '0.1prev',
        :pdescr => proc {pname + " " + pversion},
        :root => File.join(File.dirname(__FILE__),"..")
  end

  configure :production do
    set :haml => {:ugly => true},
        :sass => {:style => :compressed}
  end

  load 'helpers.rb'
  load 'routes.rb'
end
