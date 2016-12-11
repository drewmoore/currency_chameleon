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

    def convert_to(target_currency)
      self.class.new(
        amount * @@conversion_rates[currency][target_currency], target_currency
      )
    end

    # Sets conversion rates for a given currency.
    def self.conversion_rates(currency, rates)
      # If there is already a set of conversion rates for this currency,
      # append or replace with the new rates. Otherwise, set the new rates.
      @@conversion_rates[currency] ||= {}
      rates.each { |target, rate| @@conversion_rates[currency][target] = rate }
    end
  end
end
