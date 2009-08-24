$:.unshift File.join(File.dirname(__FILE__), 'app')
require 'app/server'
run Server
