FROM ruby:3.0.2-buster
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libpq-dev
RUN mkdir /cs
WORKDIR /cs
COPY Gemfile /cs/Gemfile
COPY Gemfile.lock /cs/Gemfile.lock
RUN bundle install
COPY . /cs

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
