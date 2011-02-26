# -*- coding: utf-8 -*-

class AppTemplate < Sinatra::Base
  set :sessions, false
  set :logging, true
  set :dump_errors, true
  #set :some_custom_option, false
  set :public, './public'

  configure(:development) do
    register Sinatra::Reloader
  end

  get '/' do
    puts 'show index'
    'index'
  end

  get '/index' do
    erb :index
  end
end

