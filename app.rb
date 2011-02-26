# -*- coding: utf-8 -*-

# ======================================================================
#
# This class is 'modular' type template.
#
# ======================================================================
class AppTemplate < Sinatra::Base
  set :sessions, false
  set :logging, true
  set :dump_errors, true
  set :some_custom_option, false
  set :public, './public'


  # reload this class on development environment.
  configure(:development) do
    register Sinatra::Reloader
  end


  # ----------------------------------------------------------------------
  # direct response template
  # ----------------------------------------------------------------------
  get '/' do
    puts 'show index'
    'index'
  end


  # ----------------------------------------------------------------------
  # erb template
  # ----------------------------------------------------------------------
  get '/index' do
    erb :index
  end
end

