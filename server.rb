require 'rubygems'
require 'rack'
require 'sinatra/base'
require 'identitymap'

class Server < ::Sinatra::Base
  use ::Dickpunch::IdentityMap
  
  log = File.new("log/sinatra.log", "a")
  STDOUT.reopen(log)
  STDERR.reopen(log)
  
  configure do
    disable :run
    enable :sessions
    # project-related
    set :pname => 'SimpleReports',
        :pversion => '0.1prev',
        :pdescr => proc {pname + " " + pversion}
  end

  configure :production do
    set :haml => {:ugly => true},
        :sass => {:style => :compressed}
  end
  
  load 'helpers.rb'
  load 'routes.rb'
  
end