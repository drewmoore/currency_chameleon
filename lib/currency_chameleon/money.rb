# Module for namespacing the Money class.
module CurrencyChameleon
  # Class for storing, performing calculations on, and diplaying a monetary
  # value in a variety of currencies.
  class Money
    attr_reader :amount, :currency

    # Define private class methods.
    class << self
      attr_accessor :exchange_table

      def convert_amount(amount, base, secondary)
        return amount if base == secondary
        if @exchange_table[base]
          amount * @exchange_table[base][secondary]
        else
          amount / @exchange_table[secondary][base]
        end
      end
    end

    def initialize(amount, currency)
      @amount   = amount
      @currency = currency
    end

    def inspect
      "#{format('%0.2f', amount)} #{currency}"
    end

    def convert_to(secondary)
      self.class.new(
        self.class.convert_amount(amount, currency, secondary), secondary
      )
    end

    [:+, :-, :*, :/].each do |operator|
      define_method(operator) { |other| arithmetic(operator, other) }
    end

    # Sets conversion rates for a given currency.
    def self.conversion_rates(base, rates)
      # If there is already a set of conversion rates for this currency,
      # append or replace with the new rates. Otherwise, set the new rates.
      @exchange_table ||= {}
      @exchange_table[base] ||= {}
      rates.each do |secondary, rate|
        @exchange_table[base][secondary] = rate
      end
    end

    private

    def arithmetic(operator, other)
      operand = if other.instance_of?(self.class)
                  self.class.convert_amount(
                    other.amount, other.currency, currency
                  )
                else
                  other
                end
      self.class.new(amount.send(operator, operand), currency)
    end
  end
end
