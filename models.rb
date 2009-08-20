

class Album
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :key => true
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :reports
end

# Stores the 1..N <-> 1..N relation between Report and Diff
class Diffization
  include DataMapper::Resource
  property :id,         Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :report
  belongs_to :album
end

class Report
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :key => true
  property :content,    Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :album
  has n, :diffizations
  has n, :diffs, :through => :diffizations
end

class Diff
  include DataMapper::Resource
  property :id,         Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :diffizations
  has n, :reports, :through => :diffizations
end

#Dir.entries(filename).find_all{|e| e[0] != '.'[0]}.to_json()
#File.open(filename, "r") { |f| f.read }
