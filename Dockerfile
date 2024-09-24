# Use an official Ruby runtime as a parent image
FROM ruby:2.7.1

# Set environment variables for Rails
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Install essential packages
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install --without development test

# Copy the entire application into the container
COPY . .

# Precompile assets (if needed)
RUN bundle exec rake assets:precompile

# Expose the port the Rails app will run on
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
