# CurrencyConverter

[![Gem Version](https://badge.fury.io/rb/currency_converter.svg)](https://badge.fury.io/rb/currency_converter) [![Build Status](https://travis-ci.org/dark-prince/currency_converter.svg?branch=master)](https://travis-ci.org/dark-prince/currency_converter) [![Code Climate](https://codeclimate.com/github/dark-prince/currency_converter.png)](https://codeclimate.com/github/dark-prince/currency_converter) [![Dependency Status](https://gemnasium.com/dark-prince/currency_converter.svg)](https://gemnasium.com/dark-prince/currency_converter) [![License](http://img.shields.io/license/MIT.png)](http://opensource.org/licenses/MIT) [![Coverage Status](https://coveralls.io/repos/github/dark-prince/currency_converter/badge.svg?branch=master)](https://coveralls.io/github/dark-prince/currency_converter?branch=master)

Simple Ruby API to get exchange rates from currencies using Yahoo finance currency converter and XE currency converter. You can convert currencies directly through this library.

## Installation

Add this line to your application's Gemfile:

    gem 'currency_converter'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install currency_converter

## Usage

To convert between two currencies using XE currency converter:

    currency_converter = CurrencyConverter::XE.new
    currency_converter.exchange('EUR', 'USD', 100)
    => 132.89

    currency_converter.exchange('USD', 'EUR', 100)
    => 75.15

To convert between two currencies using Yahoo finance currency converter:

    currency_converter = CurrencyConverter::Yahoo.new
    currency_converter.exchange('EUR', 'USD', 1)
    => 1.33

    currency_converter.exchange('USD', 'EUR', 1)
    => 0.75

## Contributing

1. Fork it
2. Add tests for it.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
