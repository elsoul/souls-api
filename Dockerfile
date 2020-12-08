FROM ruby:3.0.0preview2

RUN apt-get update -qq && apt-get install -y nodejs redis-server cron

USER root

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.2.0
RUN bundle
COPY . /myapp
# RUN gem install souls

RUN chmod 777 -R /myapp/tmp
RUN whenever --update-crontab

EXPOSE 3000
CMD ["foreman", "start"]