source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'

gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'sqlite3'

  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
