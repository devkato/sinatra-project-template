
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
  end

  configure do
    # asset pipeline
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

    # MongoDB
    options = YAML.load_file('./mongodb.yml')[ENV['RACK_ENV']]
    mongo_client = Mongo::MongoClient.new(options['host'], options['port'])
    db = mongo_client.db(options['database'])
    # db.authenticate(options['username'], options['password'])

    set :mongo, db
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

  get '/records' do
    content_type :json
    settings.mongo['raw'].find.to_a.to_json
  end

  # ----------------------------------------------------------------------
  # expected format of parameters is:
  #
  # params = {
  #   device: {
  #     system_version: (string),
  #     app_version:    (string),
  #     uuid:           (string),
  #     system_name:    (string),
  #     model:          (string)
  #   },
  #
  #   data: (json formatted string)
  # }
  # ----------------------------------------------------------------------
  post '/api/app/v1/beacon' do

    device = Yajl::Parser.new(symbolize_keys: true).parse(params['device'])
    device[:system_major_version] = device[:system_version].split(/\./)[0].to_s

    data = Yajl::Parser.new(symbolize_keys: true).parse(params['data'])

    # ap "device --------------------------------------------------------------------------------"
    # ap device
    # ap "data --------------------------------------------------------------------------------"
    # ap data

    now = Time.now

    store_data = {
      timestamp:  now.to_i,
      device:     device,
      data:       data,
    }

    settings.mongo['raw'].insert store_data

    # response json
    content_type :json
    status 200
    { status:  'success', timestamp: Time.now.to_i }.to_json
  end

  get '/api/web/v1/beacon' do
    puts '/api/web/v1/beacon called'

    event_name = params['e']
    data = Yajl::Parser.new(symbolize_keys: true).parse(params['d'])

    # puts "event_name -> #{event_name}"
    # ap data

    now = Time.now

    store_data = {
      timestamp:  now.to_i,
      event_name: event_name,
      # device:     device,
      data:       data,
    }

    settings.mongo['raw'].insert store_data

    # response blank gif
    content_type 'image/gif'
    status 200
    Base64.decode64("R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==")
  end
end

