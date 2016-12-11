# Currency Chameleon

This is a simple currency tool for converting, calculating, and comparing monetary values between currencies.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'currency_chameleon', git: 'git://github.com/drewmoore/currency_chameleon'
```

And then execute:

    $ bundle

## Usage

First, you will need to setup a table of conversion rates between currencies. For example:
```ruby
CurrencyChameleon::Money.conversion_rates(
  'EUR', 'USD' => 1.05507, 'Bitcoin' => 0.00137
)
```

Then, you can instantiate a new CurrencyChameleon::Money object in a currency:

`euros = CurrencyChameleon::Money.new(23, 'EUR')`

To simply return the amount:

`euros.amount # => 23`

or return the currency:

`euros.currency # => "EUR"`

You can also convert the amount to a secondary currency, which returns a new money instance:
```ruby
dollars = euros.convert_to('USD') # => 24.27 USD
dollars.currency # => "USD"
```

Money objects can perform mathematical operations between currencies, returning an instance in base currency:
```ruby
dollars = CurrencyChameleon::Money.new(47, 'USD')
euros   = CurrencyChameleon::Money.new(12, 'EUR')
total   = dollars + euros # => 59.66 USD

total.class # => CurrencyChameleon::Money
```

Money objects can also be compared against each other with any operator:
```ruby
euros    = CurrencyChameleon::Money.new(2, 'EUR')
bitcoins = CurrencyChameleon::Money.new(2, 'Bitcoin')

euros == bitcoins # => false
euros > bitcoins  # => false
euros < bitcoins  # => true
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
