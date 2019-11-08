# README

## How to launch docker project
```
docker-compose up -d
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

### Launch tests
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
