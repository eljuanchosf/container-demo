FROM ruby:2.5.1
LABEL mantainer="Juan Pablo Genovese"

# Image basic configuration
ENV APP_HOME /app
ENV PORT 9292
ENV RACK_ENV production
EXPOSE 9292

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
# Upload source
ADD . $APP_HOME

# Install gems
RUN bundle install

# Start server
ENTRYPOINT ["rackup", "config.ru"]
