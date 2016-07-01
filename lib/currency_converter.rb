require "currency_converter/exceptions"
require "currency_converter/currencies"
require "currency_converter/version"
require "net/http"

module CurrencyConverter
  class << self
    # Returns the Symbol of 'from' currency
    attr_reader :from_currency

    # Returns the Symbol of 'to' currency
    attr_reader :to_currency

    # Receive the amount of you desire currency.
    #
    # @param [String, String, Numeric] other currency to exchange to.
    #
    # @return [amount]
    #
    # @example
    # CurrencyConverter.exchange("USD", "EUR", 100)
    # CurrencyConverter.exchange("USD", "INR", 100)
    def exchange(from, to, fixnum)
      @from_currency = from.upcase.to_sym
      @to_currency = to.upcase.to_sym
      validate_currency
      ex_rate = exchange_rate
      validate_rate(ex_rate)
      ex_rate.to_f * fixnum
    end

    private

    # Returns the Float value of rate or nil
    def exchange_rate
      http = Net::HTTP.new("www.google.com", 80)
      url = "/finance/converter?a=1&from=#{from_currency.to_s.upcase}&to=#{to_currency.to_s.upcase}"
      response = http.get(url)
      result = response.body
      regexp = Regexp.new("(\\d+\\.{0,1}\\d*)\\s+#{to_currency}")
      regexp.match result
      return $1
    rescue Timeout::Error
      raise StandardError, "Please check your internet connection"
    end

    # Raise errors for invalid currencies.
    def validate_currency
      raise UnknownCurrency.new(from_currency) unless CurrencyConverter::CURRENCIES.has_key?(from_currency)
      raise UnknownCurrency.new(to_currency) unless CurrencyConverter::CURRENCIES.has_key?(to_currency)
    end

    # Raise errors for missing data.
    def validate_rate(rate)
      raise MissingExchangeRate.new(from_currency, to_currency) if rate.to_f.zero?
    end
  end
end