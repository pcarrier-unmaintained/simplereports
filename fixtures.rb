require 'models'
require 'dm-sweatshop'

Album.fixture {{
  :name => /\w+/.gen,
  :reports => (10..50).of { Report.make }
}}

Report.fixture {{
  :name => /\w+/.gen
}}
