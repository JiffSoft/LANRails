ActionController::Routing::Routes.draw do |map|
  # Forums - what a mess!
  #  map.resources :forums do |forum|
  #    forum.resources :threads do |thread|
  #      thread.resources :posts
  #    end
  #  end
  map.from_plugin :savage_beast

  # Parties
  map.resources :party, :has_many => [:tournaments, :registrations]
  map.resources :tournaments, :has_many => [:prizes, :teams]

  # News
  map.resources :news

  # Account
  map.resource :account

  # Admin
  map.site_settings 'admin/site_settings', :controller => 'admin', :action => 'settings', :conditions => {:method => :get}
  map.site_settings 'admin/site_settings', :controller => 'admin', :action => 'save_settings', :conditions => {:method => :post}

  # Custom shizzy
  map.profile 'user/:user_id', :controller => 'accounts', :action => 'view'
  map.logout 'logout', :controller => 'accounts', :action => 'logout'
  map.login 'login', :controller => 'accounts', :action => 'login', :conditions => {:method => :post}
  map.login 'login', :controller => 'accounts', :action => 'login_form', :conditions => {:method => :get}
  map.activation 'activate/:activation_code', :controller => 'accounts', :action => 'activate'
  map.recovery 'recovery/:activation_code', :controller => 'accounts', :action => 'recover', :conditions => {:method => :get}
  map.recover 'recover', :controller => 'accounts', :action => 'recover', :conditions => {:method => :post}
  map.staff 'staff', :controller => 'accounts', :action => 'staff', :conditions => {:method => :get}

  # PayPal IPN
  map.ipn 'ipn', :controller => 'paypal', :action => 'ipn', :conditions => {:method => :post}

  map.root :controller => "news"
end
