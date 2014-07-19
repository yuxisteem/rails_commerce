#RailsCommerce [![Build Status](https://travis-ci.org/pavel-d/RailsCommerce.png?branch=master)](https://travis-ci.org/pavel-d/RailsCommerce) [![Code Climate](https://codeclimate.com/github/pavel-d/RailsCommerce.png)](https://codeclimate.com/github/pavel-d/RailsCommerce)

**RailsCommerce** is a ruby app for e-commerce


[Screenshots](https://github.com/pavel-d/RailsCommerce/wiki/Screenshots)

#Description

RailsCommerce has following features:

- **Admin panel**
  - **Dashboard**. Shows recent orders, unfulfilled orders count and order updates
  - **Orders tool**. Review order info, manage order's shipment and invoice status, post comments, notify customers about order
  - **Products management tool**. 
  - **Categories management tool**.
  - **Brands management tool**.
- **Store**
  - **Browse** products
  - **Search** products by keywords
  - **Filter** products by attributes
- **Checkout**
  - **Add to cart** button with ajax cart
  - **Simple** checkout for signed in/ not signed in
  - **Account creation** for new customers during checkout
  - **Email notifications**
- **Static pages**

Comes with clean `Bootstrap` based design

RailsCommerce uses `Devise` for authentication, `paperclip` for images upload, `puma` as a http server.

#Setup

* Server setup

Ruby with RVM

```
\curl -sSL https://get.rvm.io | bash -s stable
```

Nginx
```
sudo apt-get update
sudo apt-get install nginx
sudo update-rc.d nginx defaults
```

* System dependencies

ImageMagic needed for images converting and Redis for resque
```
sudo apt-get update
sudo apt-get install imagemagick redis-server
```

* Configuration
```
git clone git@github.com:pavel-d/RailsCommerce.git
bundle install

# Don't forget to edit sample configs
cp config/database.yml.sample config/database.yml
cp config/config.yml.sample config/config.yml

rake db:migrate
rails s
```



* Database creation

```
rake db:setup
```

There is no admin user by default, so you need to update any existing user to give him admin rights

```
rails c
2.1.0 :001 > User.find_by_email('paul@live.ru').update(admin: true)
```

* Database initialization

You may want to create a DB with fake products
```
rake db:demo
```

* How to run the test suite

```
rspec
```

* Deployment instructions

There is a built in [capistrano](https://github.com/pavel-d/RailsCommerce/blob/master/config/deploy.rb) script for deployment, so deploying to production is simple:

```
cap production deploy
```




