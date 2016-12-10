require 'spec_helper'

describe CurrencyChameleon::Money do
  before(:each) do
    CurrencyChameleon::Money.conversion_rates(
      'EUR', 'USD' => 1.11, 'Bitcoin' => 0.0047
    )
  end

  let(:fifty_eur) { CurrencyChameleon::Money.new(50, 'EUR') }

  it 'sets exchange rates' do
    skip('')
    # Money.conversion_rates('EUR', {
    #   'USD'     => 1.11,
    #   'Bitcoin' => 0.0047
    # })
  end

  it 'intantiates money objects in a given currency' do
    expect(fifty_eur).to be_instance_of(CurrencyChameleon::Money)
  end

  it 'returns its amount in its set currency' do
    expect(fifty_eur.amount).to eq(50)
  end

  it 'returns an indicator of its currency' do
    expect(fifty_eur.currency).to eq('EUR')
  end

  it 'returns a human-readable string description of itself on inspect' do
    expect(fifty_eur.inspect).to eq('50.00 EUR')
  end

  it 'converts its amount to a specified currency' do
    expect(fifty_eur.convert_to('USD')).to eq('55.50 USD')
  end

  it 'returns a new money instance in a specified currency based on amount' do
    skip('')
    # fifty_eur.convert_to('USD') # => 55.50 USD
  end

  describe 'Arithmetic' do
    # twenty_dollars = Money.new(20, 'USD')

    context 'addition' do
      it 'adds dollars to euros, changes amount in same currency' do
        skip('')
        # fifty_eur + twenty_dollars # => 68.02 EUR
      end
    end

    context 'subtraction' do
      it 'subtracts dollars from euros, changes amount in same currency' do
        skip('')
        # fifty_eur - twenty_dollars # => 31.98 EUR
      end
    end

    context 'division' do
      it 'divides by an integer, changes amount in same currency' do
        skip('')
        # fifty_eur / 2              # => 25 EUR
      end
    end

    context 'multiplication' do
      it 'multiplies by an integer, changes amount in same currency' do
        skip('')
        # twenty_dollars * 3         # => 60 USD
      end
    end
  end

  describe 'Comparisons' do
    context '==' do
      it 'equals another instance of same amount and currency' do
        skip('')
        # twenty_dollars == Money.new(20, 'USD') # => true
      end

      it 'does not equal instance of a differing amount, same currency ' do
        skip('')
        # twenty_dollars == Money.new(30, 'USD') # => false
      end

      it 'equals another instance of same amount after conversion' do
        skip('')
        # fifty_eur_in_usd = fifty_eur.convert_to('USD')
        # fifty_eur_in_usd == fifty_eur          # => true
      end
    end

    context 'less than, greater than' do
      it 'accurately compares amounts of instances in same currency' do
        skip('')
        # twenty_dollars > Money.new(5, 'USD')   # => true
      end

      it 'accurately compares amounts of instances in differing currencies' do
        skip('')
        # twenty_dollars < fifty_eur             # => true
      end
    end
  end
end
