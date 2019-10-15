# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  `2.6.0`

* System dependencies
  `Docker`
  `Docker Compose`

* Database creation
  `bundle exec rake db:create db:migrate`

* Database initialization
  `docker-compose -f docker-compose.service.yml up`

* How to run the test suite
  `bundle exec rspec spec`

* PostMan Collection
  * [PostMan Collection](https://github.com/squarizi/dog_walking_api/blob/master/dog_walking_api_collection.json)

* Getting Start
  * Install docker
  * Install docker-compose
  * Install gem
  * Install gem bundler
  * start dependencies with `docker-compose -f docker-compose.service.yml up`
  * create database `bundle exec rake db:create db:migrate`
  * start server application `bundle exec rails s`
