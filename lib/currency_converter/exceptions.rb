module CurrencyConverter
  # = Missing Exchange Rate
  #
  # Raised when the data for a supported currencies is +nil+ or +zero?+.
  class MissingExchangeRate < StandardError
    def initialize(from, to)
      super("Foreign exchange rate from #{from} to #{to} is missing.")
    end
  end

  # = Unknown Currency
  #
  # Raised when we try to grab data for an unsupported currency code.
  class UnknownCurrency < StandardError
    def initialize(currency_code)
      super("#{currency_code} is not supported.")
    end
  end
end