ActionController::Routing::Routes.draw do |map|
  
  # News
  map.resources :news

  # Forums - what a mess!
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end

  # Parties
  map.resources :party, :has_many => [:tournaments, :registrations, :prizes]
  map.resources :tournaments, :has_many => [:prizes, :teams]

  # Sponsors
  map.resources :sponsors, :has_many => [:prizes]

  # Account
  map.resource :account

  # Admin
  map.site_settings 'admin/site_settings', :controller => 'admin', :action => 'settings', :conditions => {:method => :get}
  map.site_settings 'admin/site_settings', :controller => 'admin', :action => 'save_settings', :conditions => {:method => :post}

  # Custom shizzy
  map.thank_you 'party/:party_id/registrations/thank_you', :controller => 'registrations', :action => 'thank_you'
  map.profile 'user/:user_id', :controller => 'accounts', :action => 'view'
  map.logout 'logout', :controller => 'accounts', :action => 'logout'
  map.login 'login', :controller => 'accounts', :action => 'login', :conditions => {:method => :post}
  map.login 'login', :controller => 'accounts', :action => 'login_form', :conditions => {:method => :get}
  map.activation 'activate/:activation_code', :controller => 'accounts', :action => 'activate'
  map.recovery 'recovery/:activation_code', :controller => 'accounts', :action => 'recover', :conditions => {:method => :get}
  map.recover 'recover', :controller => 'accounts', :action => 'recover', :conditions => {:method => :post}
  map.forgot_password 'forgot_password', :controller => 'accounts', :action => 'forgot_password', :conditions => {:method => :get}
  map.staff 'staff', :controller => 'accounts', :action => 'staff', :conditions => {:method => :get}

  # PayPal IPN
  map.ipn 'ipn', :controller => 'paypal', :action => 'ipn', :conditions => {:method => :post}

  map.root :controller => "news"
end
