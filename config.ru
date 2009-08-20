require 'rubygems'
require 'sinatra'
require 'haml'
require 'BlueCloth'
require 'json'
require 'dm-core'
require 'dm-timestamps'

require 'models.rb'
require 'helpers.rb'
require 'routes.rb'

configure do
  disable :run
  enable :sessions
  # project-related
  set :pname => 'SimpleReports',
      :pversion => '0.1',
      :pdescr => Proc.new {pname + " " + pversion},
      :pstore => File.join(File.dirname(__FILE__), 'store')
end

configure :development do
  #DataMapper.setup(:default, 'sqlite3::memory:')
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/data/dev.db")
  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  set :haml => {:ugly => true},
      :sass => {:style => :compressed}
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/data/prod.db")
  DataMapper::Logger.new(STDOUT, :warn)
end

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

Sinatra::Application.run!
