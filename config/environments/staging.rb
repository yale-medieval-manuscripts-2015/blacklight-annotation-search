AnnotationBl::Application.configure do

  # YALE for font
  # Add the fonts path
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  config.application_name = "[STAGING] IPCH < Digitally Enabled Scholarship with Medieval Manuscripts"

  # Precompile additional assets
  config.assets.precompile += %w( .svg .eot .woff .ttf )


  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Mailer
  config.action_mailer.default_url_options = { :host => '127.0.0.1:5000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {:address => "127.0.0.1", :port => 25}

end
