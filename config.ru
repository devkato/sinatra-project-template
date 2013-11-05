# -*- coding: utf-8 -*-
 
require 'bundler/setup'

# gems dependened on
Bundler.require(:default)

# use Rack::CommonLogger
 
require './app'

map AppTemplate.assets_prefix do
  run AppTemplate.sprockets
end

# application libraries

map '/' do
  run AppTemplate
end
