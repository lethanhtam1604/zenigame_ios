#!/bin/sh

if ! which brew > /dev/null 2>&1; then
  echo '`brew` command is required. See, "Homebrew" page https://brew.sh'
  exit 1
fi

# Show execute command
set -x

brew update

if which rbenv > /dev/null 2>&1; then
  brew upgrade rbenv ruby-build
else
  brew install rbenv ruby-build
fi

rbenv install 2.4.1 -s
gem install bundler

bundle install --path vendor/bundle
bundle exec pod setup
bundle exec pod install

# Hide execute command
set +x

echo 'Setup Completed! Begin work at `open zenigame.xcworkspace`.'
