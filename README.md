# README

## How to launch docker project
```
docker-compose up
docker-compose run web rake db:create
docker-compose run web rake db:schema:load
docker-compose run web rake db:seed
```

Access site on localhost:3000

## How to setup project
### Setup project with
```
rails db:create
rails db:schema:load
rails db:seed
rails server
```

### Laucnh tests
```
rails test
```

### Install gems with
```
bundle install
```

### ImageMagick needs to be installed
Find how to install it depending on your platform

Ubuntu
```
apt-get install imagemagick
```

## More

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
