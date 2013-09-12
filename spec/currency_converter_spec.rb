require "spec_helper"

describe CurrencyConverter do
  describe ".exchange" do
    it "should return the correct rate" do
      CurrencyConverter.exchange("USD", "USD", 1).should == 1.0
    end
  end

  describe "#validate_currency" do
    describe CurrencyConverter::UnknownCurrency do
      it 'should raise an error on an unsupported currency code' do
        expect { CurrencyConverter.exchange("EUR", "UNKNOWN", 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
        expect { CurrencyConverter.exchange("UNKNOWN", "EUR", 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
      end

      it 'should not raise an error for supported currency codes' do
        expect { CurrencyConverter.exchange("EUR", "USD", 100) }.not_to raise_error(CurrencyConverter::UnknownCurrency)
      end
    end
  end
end