require 'currency_converter/exceptions'
require 'currency_converter/currencies'
require 'net/http'
require 'nokogiri'

module CurrencyConverter
  class Yahoo
    # Returns the Symbol of 'base' currency
    attr_reader :from_currency

    # Returns the Symbol of 'quot' currency
    attr_reader :to_currency

    # Returns the array of currencies rates
    attr_reader :rates

    API_URL = 'https://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true?view=basic'

    def initialize
      response = fetch_data

      parse_rates(response)
    end

    # Receive the amount of you desire currency.
    #
    # @param [String, String, Numeric] other currency to exchange to.
    #
    # @return [amount]
    #
    # @example
    # currency_converter = CurrencyConverter::Yahoo.new
    # currency_converter.exchange('USD', 'EUR', 100)
    # currency_converter.exchange('USD', 'INR', 100)
    def exchange(base, quot, amount)
      @from_currency = base.upcase.to_sym
      @to_currency = quot.upcase.to_sym

      validate_currency

      base_rate = rates[from_currency].to_f
      quot_rate = rates[to_currency].to_f

      rate = base_rate.zero? ? 0 : (quot_rate / base_rate)
      validate_rate(rate)

      amount * rate
    end

    private

    def fetch_data
      Net::HTTP.get(URI(API_URL))
    end

    def parse_rates(html)
      @rates = { USD: 1.0 }

      result = Nokogiri::HTML(html)

      result.css('resource').each do |resource|
        symbol = resource.xpath(".//field[@name='symbol']").text[0,3]
        price  = resource.xpath(".//field[@name='price']").text

        rates[symbol.upcase.to_sym] = price.to_f unless symbol.nil? && price.nil?
      end
    end

    def validate_currency
      raise UnknownCurrency.new(from_currency) unless CURRENCIES.has_key?(from_currency)
      raise UnknownCurrency.new(to_currency) unless CURRENCIES.has_key?(to_currency)
    end

    def validate_rate(rate)
      raise MissingExchangeRate.new(from_currency, to_currency) if rate.zero?
    end
  end
end