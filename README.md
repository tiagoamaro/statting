# Statting

detailed statistics of the CoinShift Pool

* Ruby version
    * 2.1.1

* System dependencies
    * Bower

* Configuration
    * To install highstocks.js, run `bower install`

* Database creation
    * `rake db:create`

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
    * `clockwork -c clock.rb start`
    * `rake jobs:work`

* Deployment instructions
    * Remember to create a `config/initializer/secret_token.rb`, otherwise Rails will not initialize.
        * Example: `Statting::Application.config.secret_key_base = 'myscretoken'`