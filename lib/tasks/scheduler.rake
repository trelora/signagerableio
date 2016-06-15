desc "This task is called by the Heroku scheduler add-on"
task :update_slides => :environment do
  puts "Updating slides..."
  Slide.update_slides
  puts "Finished updating slides."

  puts "Updating roles..."
  Role.update_roles
  puts "Finished updating roles."
  puts "done."
end
