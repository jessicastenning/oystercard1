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

  describe '#in_journey?' do
    it 'should return false by default' do
      expect(subject.in_journey).to eq false
    end
  end

  describe '#touch_in' do
    it 'should change the in_journey status to true' do
      subject.top_up(10)
      subject.touch_in
      expect(subject.in_journey).to eq true
    end
    it 'shouldnt allow you to touch in if you unless you have the minimum balance' do
      expect{ subject.touch_in }.to raise_error "balance too low, the minimum balance is £#{Oystercard::MINIMUM_BALANCE}"
    end
  end

  describe '#touch_out' do
    it 'should change the in_journey status to false' do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
  end
end
