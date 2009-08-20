require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'
require 'dm-core'

require 'models.rb'
require 'routes.rb'

configure do
  disable :run
  enable :sessions
  # project-related
  set :pname => 'VROUMS',
      :pversion => '0.1',
      :pdescr => Proc.new {pname + " " + pversion},
      :pstore => File.join(File.dirname(__FILE__), 'store')
end

configure :development do
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/dev.db")
  #DataMapper.setup(:default, 'sqlite3::memory:')
  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/prod.db")
  set :haml => {:ugly => true},
      :sass => {:style => :compressed}
end

log = File.new("sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

Sinatra::Application.run!
