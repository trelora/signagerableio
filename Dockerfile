FROM 500236686353.dkr.ecr.us-east-1.amazonaws.com/ruby:v65

# https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#debian--ubuntu
RUN apt-get update
RUN apt-get install -y g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

ENV APP_HOME /app
ENV trelora_base_url "https://api.trelora.com"
ENV trelora_api_key "Nm1zdUVZRFNtbmVObXVOTmFyanA6Nm1zdUVZRFNtbmVObXVOTmFyanA="

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN bundle install

CMD ["./docker-start.sh"]

EXPOSE 5000
