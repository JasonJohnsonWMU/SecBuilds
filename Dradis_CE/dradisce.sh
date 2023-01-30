#!/bin/bash

# We'll install Dradis in our home directory, so change to home and update and upgrade
cd ~
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y git \
  curl \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
  libdb-dev

# Intall rbenv to manage Ruby
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src && cd ..

# Add appropriate lines to .bashrc so rbenv will load in new shells
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

# Initialize rbenv so we can use it during this session
~/.rbenv/bin/rbenv init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"

# We'll use ruby-build to install ruby versions
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Install the ruby version required by Dradis
rbenv install 3.1.2

# Install required packages
sudo apt install -y libpq-dev libsqlite3-dev

# Clone Dradis 
git clone https://github.com/dradis/dradis-ce.git

# Change to the dradis-ce directory and set the appropriate ruby version
cd dradis-ce/
rbenv local 3.1.2

# Set up Dradis
./bin/setup

echo "Now you can start Dradis with './bin/rails server' and navigate to http://localhost:3000 in your browser to use it."
