# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require 'yaml'
  def site_title
    Settings.global_title
  end
end
