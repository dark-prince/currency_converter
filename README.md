# CurrencyConverter

Google provides a web site to converts currencies using exchange rates but they have not provided any API for ruby. This is a small library that converts currencies exchange rate. You can convert currencies directly through this library.

## Installation

Add this line to your application's Gemfile:

    gem 'currency_converter'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install currency_converter

## Usage

To convert between two currencies:

    CurrencyConverter.exchange("EUR", "USD", 100)
    => 132.89

    CurrencyConverter.exchange("USD", "EUR", 100)
    => 75.15

To get the most recent exchange rate between two currencies:

    CurrencyConverter.exchange("EUR", "USD", 1)
    => 1.33

    CurrencyConverter.exchange("USD", "EUR", 1)
    => 0.75

## Contributing

1. Fork it
2. Add tests for it.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
