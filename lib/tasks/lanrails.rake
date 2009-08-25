namespace :lanrails do
  desc "Make a user an admin"
  task :make_admin => :environment do
    if not ENV['user_name']
      puts "Usage: rake lanrails:make_admin user_name=<username>"
    end
    @u = User.find_by_username(ENV['user_name'])
    if not @u
      raise "User not found!"
    end
    @u.status = User::STATUS_ADMIN
    @u.save!
    puts "done"
  end
end