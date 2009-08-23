require 'dm-core'
require 'dm-timestamps'

Env = ENV['RAILS_ENV'] || ENV['MERB_ENV'] || ENV['RACK_ENV'] || 'development'

case Env
when 'development'
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/dev.db")
else
  DataMapper::Logger.new(STDOUT, :warn)
  DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/prod.db")
end
