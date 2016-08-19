require "spec_helper"

describe CurrencyConverter::Google do
  let(:currency_converter) { CurrencyConverter::Google.new }

  describe "#exchange" do
    it "returns the correct rate" do
      expect(currency_converter.exchange("USD", "USD", 1)).to eq 1
    end
  end

  describe "#validate_currency" do
    describe CurrencyConverter::UnknownCurrency do
      it 'raise an error on an unsupported currency code' do
        expect { currency_converter.exchange("EUR", "UNKNOWN", 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
        expect { currency_converter.exchange("UNKNOWN", "EUR", 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
      end

      it 'doesn\'t raise an error for supported currency codes' do
        expect { currency_converter.exchange("EUR", "USD", 100) }.not_to raise_error
      end
    end
  end
end