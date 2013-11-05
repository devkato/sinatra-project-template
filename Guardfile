require 'bundler/setup'
Bundler.require(:default)
require './app'

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# guard 'livereload' do
#   watch(%r{app/views/.+\.(erb|haml|slim)$})
#   watch(%r{app/helpers/.+\.rb})
#   watch(%r{public/.+\.(css|js|html)})
#   watch(%r{config/locales/.+\.yml})
#   # Rails Assets Pipeline
#   watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
# end

# guard 'shotgun' do
#   watch('app.rb')
# end

guard 'sprockets2',
  :sprockets    =>  AppTemplate.sprockets,
  :assets_path  =>  AppTemplate.assets_path,
  :precompile   =>  AppTemplate.precompile,
  :digest       =>  AppTemplate.digest_assets do
  watch(%r{^assets/.+$})
  watch('app.rb')
end
