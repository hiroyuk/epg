namespace :load_program do

  desc 'load ts scheduler'
  task :exec, ['file_name'] => :environment do |t, args|
    loader = Epg::Loader.new
    loader.load(loader.ts_to_json(args[:file_name]))

    loader.delete_old_program
  end
end
