#!/bin/sh

# Set up Rails app. Run this script immediately after cloning the codebase.

# Set up Ruby dependencies
bundle install

# Set up database
bundle exec rake db:setup

rake db:migrate
rake db:seed

