# Module for namespacing the Money class.
module CurrencyChameleon
  # Class for storing, performing calculations on, and diplaying a monetary
  # value in a variety of currencies.
  class Money
    attr_reader :amount, :currency

    # Define private class methods.
    class << self
      # Maintain a class-level table of exchange rates.
      # i.e.{ 'EUR' => { 'USD' => 1.11 } }
      attr_accessor :exchange_table

      # Convert any amount in a base currency to one in a secondary currency.
      # If there there is no exchange rate entry for the base, find any entry
      # for the secondary currency and inverse the operation.
      def convert_amount(amount, base, secondary)
        return amount if base == secondary
        if @exchange_table[base]
          amount * @exchange_table[base][secondary]
        else
          amount / @exchange_table[secondary][base]
        end
      end
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

    def initialize(amount, currency)
      @amount   = amount
      @currency = currency
    end

    # Define common methods for mathematic operators in shorthand.
    [:+, :-, :*, :/].each do |operator|
      # Piece together an equation for any mathematical operator. Determine the
      # other amount to pass to calculation based on its class.
      define_method(operator) do |other|
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

    # Define common methods for comparisons in shorthand.
    [:==, :>, :<, :>=, :<=].each do |comparator|
      define_method(comparator) do |other|
        # Piece together a comparison by converting the other amount to the
        # correct currency, if needed.
        comparand = self.class.convert_amount(
          other.amount, other.currency, currency
        )
        amount.send(comparator, comparand)
      end
    end

    # Override default object inspect.
    def inspect
      "#{format('%0.2f', amount)} #{currency}"
    end

    # Convert the amount to the secondary currency and return a new instance
    # in the secondary currency.
    def convert_to(secondary)
      self.class.new(
        self.class.convert_amount(amount, currency, secondary), secondary
      )
    end
  end
end
