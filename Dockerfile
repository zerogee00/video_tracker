FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get update && apt-get install -y postgresql-client mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN mkdir /video_tracker
WORKDIR /video_tracker
COPY Gemfile /video_tracker/Gemfile
COPY Gemfile.lock /video_tracker/Gemfile.lock
RUN bundle install
COPY . /video_tracker