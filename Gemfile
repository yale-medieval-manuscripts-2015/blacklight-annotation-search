source 'https://rubygems.org'
ruby "2.2.4"

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem "therubyracer", :platforms => :ruby


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'mysql2'
end

group :production do
  #
  #
  #
  # gem 'pg'
  gem 'pg', '0.15.1'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'


gem 'autoprefixer-rails'

gem 'rake'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'blacklight', '4.1.0'
#gem 'blacklight-hierarchy', :path => "/Users/rlechich/rails_projects/blacklight-hierarchy"
#gem 'blacklight-hierarchy', :git => 'git://github.com/ydc2/blacklight-hierarchy', :branch => 'desmm'
gem 'blacklight-hierarchy', github: 'ydc2/blacklight-hierarchy', tag: 'v0.2.1'

gem "unicode", :platforms => [:mri_18, :mri_19]
gem "devise"
gem "devise-guests", "~> 0.3"
gem "bootstrap-sass", "~> 2.2.0"
gem "omniauth-cas"

gem "kaminari", "0.15.1"

gem 'unicorn'
