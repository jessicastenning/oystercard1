require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'should have a default balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should allow the user to top up the card balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
  end
end
