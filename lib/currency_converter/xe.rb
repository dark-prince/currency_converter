require 'currency_converter/exceptions'
require 'currency_converter/currencies'
require 'net/http'
require 'nokogiri'

module CurrencyConverter
  class XE
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
    # currency_converter = CurrencyConverter::XE.new
    # currency_converter.exchange('USD', 'EUR', 100)
    # currency_converter.exchange('USD', 'INR', 100)
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
      url = "/currencyconverter/convert/?Amount=1&From=#{from_currency.to_s.upcase}&To=#{to_currency.to_s.upcase}"
      uri = URI.parse('https://www.xe.com')

      request = Net::HTTP.new(uri.host, uri.port)
      request.use_ssl = true
      response = request.get(url)

      doc = Nokogiri::HTML(response.body)
      result = doc.css('span.uccResultAmount').text

      regexp = Regexp.new('(\\d+(?:\\.\\d+)?)')
      regexp.match result

      return $1
    rescue Timeout::Error
      raise StandardError, 'Please check your internet connection'
    end

    def validate_currency
      raise CurrencyConverter::UnknownCurrency.new(from_currency) unless CurrencyConverter::CURRENCIES.has_key?(from_currency)
      raise CurrencyConverter::UnknownCurrency.new(to_currency) unless CurrencyConverter::CURRENCIES.has_key?(to_currency)
    end

    def validate_rate(rate)
      raise CurrencyConverter::MissingExchangeRate.new(from_currency, to_currency) if rate.to_f.zero?
    end
  end
end