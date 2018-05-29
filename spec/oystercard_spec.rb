require 'oystercard'

describe Oystercard do
let(:station){ double :station }
let(:station2){ double :station }

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

  describe '#in_journey?' do
    it 'should return false by default' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'should change the in_journey status to true' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end
    it 'shouldnt allow you to touch in if you unless you have the minimum balance' do
      expect{ subject.touch_in(station) }.to raise_error "balance too low, the minimum balance is £#{Oystercard::MINIMUM_BALANCE}"
    end
    it 'should record the entry station on touch_in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'should change the in_journey status to false' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.in_journey?).to eq false
    end
    it 'should reduce card balance by the minimum fare' do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out(station2) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end
    it 'should set the entry station to nil on touch_out' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#journeys' do
    it 'should have an empty journey history on initialization' do
      expect(subject.journeys).to be_empty
    end
    it 'should store a journey' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station2)
      last_journey = subject.journeys.pop
      expect(last_journey[:entry_station]).to eq station
      expect(last_journey[:exit_station]).to eq station2
    end
    it 'should reset current_journey' do
    subject.touch_out(station)
    expect(subject.instance_variable_get(:@current_journey)).to be_an_instance_of(Hash).and be_empty
    end
  end
end
