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
    it 'should not allow the user to top up more than the MAXIMUM_BALANCE' do
      expect{ subject.top_up(Oystercard::MAXIMUM_BALANCE + 1) }.to raise_error "balance cannot exceed #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe '#deduct' do
    it 'should deduct the cost of the journey from the card balance' do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq 5
    end
  end
end
