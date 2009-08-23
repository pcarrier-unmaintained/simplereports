require 'rubygems'
require 'rack'
require 'sinatra'
require 'haml'
require 'bluecloth'

configure do
  disable :run
  enable :sessions
  # project-related
  set :pname => 'SimpleReports',
      :pversion => '0.1prev',
      :pdescr => Proc.new {pname + " " + pversion},
end

configure :production do
  set :haml => {:ugly => true},
      :sass => {:style => :compressed}
end

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'models.rb'
require 'helpers.rb'
require 'routes.rb'

run Sinatra::Application
