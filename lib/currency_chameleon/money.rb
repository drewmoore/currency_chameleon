# Module for namespacing the Money class.
module CurrencyChameleon
  # Class for storing, performing calculations on, and diplaying a monetary
  # value in a variety of currencies.
  class Money
    attr_reader :amount, :currency

    @@conversion_rates = {}

    def initialize(amount, currency)
      @amount   = amount
      @currency = currency
    end

    def inspect
      "#{format('%0.2f', amount)} #{currency}"
    end

    def convert_to(new_currency)
      exchange_rate = @@conversion_rates[@currency][new_currency]
      @amount      *= exchange_rate
      @currency     = new_currency
      inspect
    end

    def self.conversion_rates(currency, rates)
      if @@conversion_rates[currency]
        rates.each { |k, v| @@conversion_rates[currency][k] = v }
      else
        @@conversion_rates[currency] = rates
      end
    end
  end
end
