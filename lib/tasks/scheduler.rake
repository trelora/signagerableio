desc "This task is called by the Heroku scheduler add-on"
task :update_slides => :environment do
  puts "Updating slides and roles..."
  Admin::SlidesController.new.background_update
  puts "done."
end
