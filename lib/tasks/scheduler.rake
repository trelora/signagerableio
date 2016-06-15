desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating slides and roles..."
  Admin::SlidesController.new.update
  puts "done."
end
