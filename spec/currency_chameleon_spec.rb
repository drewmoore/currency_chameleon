require 'spec_helper'

describe CurrencyChameleon::Money do
  before(:each) do
    @bitcoin_rate = 0.00137
    CurrencyChameleon::Money.conversion_rates(
      'EUR', 'USD' => 1.05507, 'Bitcoin' => @bitcoin_rate
    )
  end

  let(:fifty_eur)      { CurrencyChameleon::Money.new(50, 'EUR') }
  let(:twenty_dollars) { CurrencyChameleon::Money.new(20, 'USD') }

  it 'sets exchange rates' do
    euro    = CurrencyChameleon::Money.new(5, 'EUR')
    bitcoin = CurrencyChameleon::Money.new(5, 'Bitcoin')
    expect((euro / bitcoin).amount).to eq(@bitcoin_rate)
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
    expect(fifty_eur.convert_to('USD').amount.round(2)).to eq(52.75)
  end

  it 'returns a new money instance in a specified currency based on amount' do
    expect(fifty_eur.convert_to('USD')).to(
      be_instance_of(CurrencyChameleon::Money)
    )
  end

  describe 'Arithmetic' do
    it 'adds dollars to euros, changes amount in same currency' do
      result = fifty_eur + twenty_dollars
      expect(result.inspect).to eq('68.96 EUR')
    end

    it 'subtracts dollars from euros, changes amount in same currency' do
      result = fifty_eur - twenty_dollars
      expect(result.inspect).to eq('31.04 EUR')
    end

    it 'divides by an integer, changes amount in same currency' do
      result = fifty_eur / 2
      expect(result.inspect).to eq('25.00 EUR')
    end

    it 'multiplies by an integer, changes amount in same currency' do
      result = twenty_dollars * 3
      expect(result.inspect).to eq('60.00 USD')
    end
  end

  describe 'Comparisons' do
    context '==' do
      it 'equals another instance of same amount and currency' do
        expect(twenty_dollars).to eq(CurrencyChameleon::Money.new(20, 'USD'))
      end

      it 'does not equal instance of a differing amount, same currency ' do
        expect(twenty_dollars).not_to(
          eq(CurrencyChameleon::Money.new(30, 'USD'))
        )
      end

      it 'equals another instance of same amount after conversion' do
        expect(fifty_eur.convert_to('USD')).to eq(fifty_eur)
      end
    end

    context 'less than, greater than' do
      it 'accurately compares amounts of instances in same currency' do
        expect(twenty_dollars).to be > CurrencyChameleon::Money.new(5, 'USD')
      end

      it 'accurately compares amounts of instances in differing currencies' do
        expect(twenty_dollars).to be < fifty_eur
      end
    end
  end
end
