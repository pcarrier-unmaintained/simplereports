task :migrate do
  require 'app/models'
  DataMapper.auto_migrate!
end

task :populate do
  require 'fixtures'
  20.of {Album.gen}
end
