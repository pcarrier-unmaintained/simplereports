require 'models.rb'
require 'dm-sweatshop'

Album.fixture {{
  :name => /\w+/.gen,
  :reports => (10..50).of { Report.fixture }
}}

Report.fixture {{
  :name => /\w+/.gen
}}
