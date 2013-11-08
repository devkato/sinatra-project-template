
# disable foreman stdout buffering
# $stdout.sync = true
# $stderr.sync = true

# ======================================================================
#
# This class is 'modular' type template.
#
# ======================================================================
class AppTemplate < Sinatra::Base

  disable :logging

  # sinatra general configurations
  set :sessions,            false
  set :logging,             false
  set :dump_errors,         true
  set :some_custom_option,  false
  set :public_dir,          './public'

  # haml configurations
  set :haml,                format: :html5

  # sprockets configurations
  set :sprockets,     Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :assets_path,   File.join(public_dir, assets_prefix)
  set :digest_assets, true

  # reload this class on development environment.
  configure(:development) do
    register Sinatra::Reloader
    # set :logging, nil
    # logger = Logger.new STDOUT
    # logger.level = Logger::INFO
    # logger.datetime_format = '%a %d-%m-%Y %H%M '
    # set :logger, logger
  end

  configure do
    sprockets.append_path(File.join(root, 'assets', 'stylesheets'))
    sprockets.append_path(File.join(root, 'assets', 'javascripts'))
    sprockets.append_path(File.join(root, 'assets', 'images'))

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder

      config.debug = true
    end
  end

  helpers do
    include Sprockets::Helpers
  end


  # ----------------------------------------------------------------------
  # direct response template
  # ----------------------------------------------------------------------
  get '/' do
    haml :index
  end

  post '/api/v1/beacon' do

    device = Yajl::Parser.new(symbolize_keys: true).parse(params['device'])
    device[:system_major_version] = device[:system_version].split(/\./)[0].to_s

    data = Yajl::Parser.new(symbolize_keys: true).parse(params['data'])

    ap "device --------------------------------------------------------------------------------"
    ap device
    ap "data --------------------------------------------------------------------------------"
    ap data

    content_type :json

    status 200
    { status:  'success', timestamp: Time.now.to_i }.to_json
  end
end

