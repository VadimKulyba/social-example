source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '0.18.4'
gem 'rails', '~> 5.1.4'

gem 'bcrypt-ruby'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.7'

gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '~> 5.0'

gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'devise'
gem 'omniauth-vkontakte'

group :development, :test do
  gem 'capybara', '2.8.0'
  gem 'rspec-rails', '3.5.1'
  gem 'selenium-webdriver'
  # gem 'sqlite3'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_girl_rails', '4.2.1'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
