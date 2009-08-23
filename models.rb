require 'db.rb'

# Singular = Plural (no removal of the 's')
Extlib::Inflection.singular_word("analysis", "analysis")

class Album
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :key => true
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :reports
  has n, :analysis
end

class Report
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :key => true
  property :content,    Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :album
  has n, :analysis, :through => Resource
end

class Analysis
  include DataMapper::Resource
  property :id,         Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :reports, :through => Resource
  belongs_to :album
end

#File.open(filename, "r") { |f| f.read }