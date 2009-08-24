require 'db'

# Singular = Plural (no removal of the 's')
Extlib::Inflection.singular_word('analysis', 'analysis')

class Album
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :unique_index => true
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :reports, :constraint => :destroy
  has n, :analysis, :constraint => :set_nil
  default_scope(:default).update(:order => [:name])
end

class Report
  include DataMapper::Resource
  property :id,         Serial
  property :name,       String, :unique_index => true
  property :content,    Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :album
  has n, :analysis, :through => Resource, :constraint => :destroy
  default_scope(:default).update(:order => [:name])
end

class Analysis
  include DataMapper::Resource
  property :id,         Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  has n, :reports, :through => Resource, :constraint => :destroy
  belongs_to :album
end
