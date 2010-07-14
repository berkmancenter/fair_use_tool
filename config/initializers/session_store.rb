# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_final_session',
  :secret      => 'ecc50868f05ec26a518b947c75abe772f51c4f32eb03c579f769e0abb6bc8f755e540a03dc4ffc60c9bd5a0a68d33a73eace0a2009b3055ee775ab8f88f13b82'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
