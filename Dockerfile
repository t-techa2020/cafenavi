FROM ruby:2.5.3

RUN apt-get update && \
	apt-get install -y \
		build-essential \
		libpq-dev \
		nodejs

RUN mkdir /cafenavi
ENV APP_ROOT /cafenavi
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT