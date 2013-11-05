 
# gems dependened on
Bundler.require(:default)

require './app'
 
namespace :assets do
  desc 'compile assets'
  task :compile => [:compile_js, :compile_css] do
  end
 
  desc 'compile javascript assets'
  task :compile_js do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.js']
    outpath   = File.join(AppTemplate.settings.assets_path, 'js')
    outfile   = Pathname.new(outpath).join('application.min.js') # may want to use the digest in the future?
 
    FileUtils.mkdir_p outfile.dirname
 
    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled js assets"
  end
 
  desc 'compile css assets'
  task :compile_css do
    sprockets = Application.settings.sprockets
    asset     = sprockets['application.css']
    outpath   = File.join(AppTemplate.settings.assets_path, 'css')
    outfile   = Pathname.new(outpath).join('application.min.css') # may want to use the digest in the future?
 
    FileUtils.mkdir_p outfile.dirname
 
    asset.write_to(outfile)
    asset.write_to("#{outfile}.gz")
    puts "successfully compiled css assets"
  end
  # todo: add :clean_all, :clean_css, :clean_js tasks, invoke before writing new file(s)
end
