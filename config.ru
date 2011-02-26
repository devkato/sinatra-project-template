# -*- coding: utf-8 -*-

require 'bundler/setup'
Bundler.require(:default)
require 'sinatra/base'
require 'sinatra/reloader' if development?
require './app'

set :environment, :development

run AppTemplate

