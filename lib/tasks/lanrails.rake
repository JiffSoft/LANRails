namespace :lanrails do
  require 'csv'

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

  desc "Adds games to the games table"
  task :insert_game_info => :environment do
    @csv_info = CSV::Reader.parse(File.open("#{RAILS_ROOT}/config/game_information.csv"))
    puts "Inserting game information..."
    @csv_info.each do |gi|
      g = Game.new
      g.name = gi[1]
      g.description = gi[2]
      g.url = gi[3]
    end
    puts "#{@csv_info.count} inserts completed"
  end
end