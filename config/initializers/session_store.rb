# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_LANRails_session',
  :secret      => 'ce89ce6571b3ce6a0ac47424f40c7a0fff2f9805a694a92eef6f007427f02c8fdc0668d49e8844a6d7e1a068541e4c34deb519d2d45380ff9d344a39315c2e2f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
