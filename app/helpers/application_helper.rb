# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def site_title
    Settings[:site_title]
  end
  
end
