# README

Rails Engine is a project in building an internal API. Feel free to clone down this project to see how it works! 

A few concepts that were highlighted in this project were namespacing, building out single-responsibility controllers with only standard CRUD operations (Only used Read functions in this project). This was also an exercising in building more intermediate ActiveRecord queries so those are present in the Models.

This project was built with TDD so the test suite is fairly robust. I have utilized the gem `simplecov` to after running the test suite, you can see the percentage of coverage on the code.

##### Rails Engine uses:
* Ruby version: 2.4.1
* Rails verson: 5.1.6

### To view this project on your local machine, follow these steps:

1. First clone the repo to your local, paste this in your chosen directory: `git@github.com:KathleenYruegas/rails_engine.git`
1. `cd` into the directory
1. run `bundle install`
1. run `rake db:{create,migrate}`
1. run `rake import_all`  (to seed all data - this can take awhile!)`

Now you are all set to explore the project!

### What is there to see?
- From the `configu/routes.rb` file, you can see the routes you can visit.  Here are a few of note:
  - `'/api/v1/invoices/1/transactions'` (where the `1` represents an invoice id) to see all transactions associated with that particular invoice.
  - `'/api/v1/merchants/most_revenue?quantity=5'` shows the top 5 merchants with the highest revenue. The number 5 can be replaced with a different number if you are wanting a different amount of merchants.
  - `'/api/v1/items/revenue?date=2012-03-16'` will show the revenue across all merchants for the given date.


### How to run the test suite
This project uses RSpec for it's testing suite. You can run the test suite from typing `rspec` into the terminal from the root of the project.  


