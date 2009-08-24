task :migrate do
  require 'models'
  DataMapper.auto_migrate!
end

task :populate do
  require 'fixtures'
  20.of {Album.gen}
end