source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"

gem "jbuilder"

gem "devise-i18n"
gem "devise"
gem 'otp-jwt'


gem "discard"
gem "rails-i18n"
gem "view_component"
gem "sorbet-runtime"

gem "pundit"
gem "shrine"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "standard-sorbet"
  gem "rubocop-sorbet", require: false
  gem "sorbet"                  # the static type checker. Use `sorbet-runtime` (above) for runtime checks
  gem "tapioca"                 # generate RBIs
  gem "rspec-sorbet"
end

group :development do
  gem "web-console"
  gem "i18n-tasks"
  gem "lefthook"
  gem "bullet"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
end
