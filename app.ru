require File.join(File.dirname(__FILE__), 'app.rb')

configure do
disable :run
enable :sessions
# project-related
set :pname => 'WoodTed',
    :pversion => '0.1',
    :pdescr => Proc.new {pname + " " + pversion},
    :pstore => File.join(File.dirname(__FILE__), 'store')
end

configure :production do
set :haml => {:ugly => true},
    :sass => {:style => :compressed}
end

Sinatra::Application.run!