FROM ruby:2.5.1
LABEL mantainer="Juan Pablo Genovese"

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 9292
ENV RACK_ENV production
EXPOSE 9292
CMD ["rackup", "config.ru"]
