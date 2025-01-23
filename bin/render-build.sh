#!/bin/bash
# Set execute permissions on bin scripts
chmod +x bin/*
# exit on error
set -o errexit

# Install dependencies
bundle install --without development test
yarn install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

# bundle exec rails db:migrate

# Precompile assets
bundle exec rake assets:precompile

# Run database migrations
bundle exec rails db:migrate