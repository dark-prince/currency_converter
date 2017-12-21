require 'spec_helper'

describe CurrencyConverter::Yahoo do
  let(:currency_converter) { described_class.new }

  context '#exchange' do
    it 'returns the correct rate' do
      expect(currency_converter.exchange('USD', 'USD', 1)).to eq 1
    end
  end

  context '#validate_currency' do
    context 'CurrencyConverter::UnknownCurrency' do
      it 'raise an error on an unsupported currency code' do
        expect { currency_converter.exchange('EUR', 'UNKNOWN', 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
        expect { currency_converter.exchange('UNKNOWN', 'EUR', 100) }.to raise_error(CurrencyConverter::UnknownCurrency)
      end

      it 'doesn\'t raise an error for supported currency codes' do
        expect { currency_converter.exchange('EUR', 'USD', 100) }.to_not raise_error
      end
    end
  end
end