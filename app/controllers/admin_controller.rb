class AdminController < ApplicationController
  before_filter :require_administrator
  require 'yaml'

  def settings
    @settings = YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))
    @themes = Array.new
    Dir["#{RAILS_ROOT}/public/stylesheets/themes/*.css"].each do |t|
      @themes.push(File.basename(t,".css"))
    end
  end

  def save_settings
    
  end
end
