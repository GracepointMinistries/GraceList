source 'https://rubygems.org'
ruby "2.5.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# DEFAULT RAILS GEMS
gem 'rails',                    '~> 5.1.6'
gem 'mysql2',                   '~> 0.3'
gem 'puma',                     '~> 3.1'            # Use Puma as the app server
# gem 'sass-rails',               '~> 5.0'            # Use SCSS for stylesheets
gem 'uglifier',                 '>= 1.3.0'          # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails',             '~> 4.2'            # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails'                                  # Use jquery as the JavaScript library
gem 'turbolinks',               '~> 5'              # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder',                 '~> 2.5'            # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'tzinfo-data',              platforms: [:mingw, :mswin, :x64_mingw, :jruby]  # Windows does ct include zoneinfo files, so bundle the tzinfo-data gem
gem 'loofah',										'>= 2.2.3'

# VENDOR GEMS
gem 'config',                   '~> 1.4.0'          # Configuration management
gem 'will_paginate',            '~> 3.1.5'          # Pagination
gem 'redcarpet',                '~> 3.3.4'          # Markdown
gem 'figaro',                   '~> 1.1.1'          # Configuration management
gem 'devise',                   '~> 4'            # Devise
gem 'omniauth-google-oauth2',   '~> 0.5'            # Omniauth Google



group :development, :test do
  gem 'byebug',           platform: :mri            # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'                                         # Pry
  gem 'pry-rails'                                   # Pry
end