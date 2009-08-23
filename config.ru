require 'rubygems'
require 'rack'
require 'sinatra'
require 'sinatra/r18n'

configure do
  disable :run
  enable :sessions
  # project-related
  set :pname => 'SimpleReports',
      :pversion => '0.1prev',
      :pdescr => Proc.new {pname + " " + pversion}
end

configure :production do
  set :haml => {:ugly => true},
      :sass => {:style => :compressed}
end

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'routes.rb'

run Sinatra::Application
