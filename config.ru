# -*- coding: utf-8 -*-

# gems dependened on
require 'bundler/setup'
Bundler.require(:default)
require 'sinatra/base'
require 'sinatra/reloader' if development?
require 'erb'

# application libraries
require './app'
run AppTemplate

