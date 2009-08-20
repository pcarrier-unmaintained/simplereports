require 'rubygems'
require 'sinatra'
require 'haml'
require 'bluecloth'
require 'dm-core'
require 'dm-timestamps'

configure do
  disable :run
  enable :sessions
  # project-related
  set :pname => 'SimpleReports',
      :pversion => '0.1',
      :pdescr => Proc.new {pname + " " + pversion},
      :pstore => File.join(File.dirname(__FILE__), 'store')
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{Dir.pwd}/data/dev.db")
end

configure :development do
  #DataMapper.setup(:default, 'sqlite3::memory:')
  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  set :haml => {:ugly => true},
      :sass => {:style => :compressed}
  DataMapper::Logger.new(STDOUT, :warn)
end

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'models.rb'
require 'helpers.rb'
require 'routes.rb'

run Sinatra::Application
