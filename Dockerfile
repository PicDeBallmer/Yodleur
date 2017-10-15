FROM ruby:2.3.3

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  imagemagick

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

# Load db schema and seed db
# RUN rake db:schema:load
# RUN rake db:seed

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# To enable remote debug from RubyMine
# RUN rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- $COMMAND$
# CMD bundle exec rdebug-ide --port 1234 --dispatcher-port 26166 --host 0.0.0.0 -- ~/app/app/bin/rails server -b 0.0.0.0 -p 3000 -e development

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]