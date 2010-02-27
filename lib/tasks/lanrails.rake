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
    @lines = File.open("#{RAILS_ROOT}/config/gameinfo.csv").readlines
    puts "Inserting game information for #{@lines.count} games..."
    n = 0
    @lines.each do |l|
      gi = l.split(',')
      game = Game.new do |g|
        g.name = gi[0]
        g.short_name = gi[1]
        g.game_type = gi[2]
      end
      if game.save!
        n += 1
      end
    end
    puts "DONE IMPORTING #{n} GAMES!"
  end
end