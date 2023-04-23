# Import Products

This project helps save products with name and images in the databse by exporting from csv file.

# Prerequisites

Make sure you have the following installed on your local machine:

- Ruby 3.0.1
- Rails 7.0.4
- PostgreSQL 1.4
- Redis 4.6.0
- Sidekiq 6.5.1
- libvip

# Getting Started

## Setting up the application

1. Run bundle :

   - `bundle install`

2. Create the database and run the migrations.
   - `rails db:create `
   - `rails db:migrate`
3. Start the Sidekiq server :
   - `bundle exec sidekiq`
4. Start the Rails server.

   - `rails s`

### NOTE:

ruby-vips gem has been used as a image processing library to optimize image insertion, if an error orrcurs while running the server,libvip should be install or ruby-vip gem sould be removed from Gemfile.

- `sudo apt install libvips`

## Running the tests

Rspec has been used to carry out tests.

- To run the tests, use the following command:
  - `rails db:test:prepare`
  - `rspec`
