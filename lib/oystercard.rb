require_relative './station'

class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = {}
  end

  def top_up(cash)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + cash > MAXIMUM_BALANCE
    @balance += cash
  end

  def touch_in(entry_station)
    fail "balance too low, the minimum balance is £#{MINIMUM_BALANCE}" if @balance < 1
    @entry_station = entry_station
    @current_journey[:entry_station] = @entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    @current_journey[:exit_station] = @exit_station
    save_journey
    reset_journey
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(fare=5)
    @balance -= fare
  end

  def save_journey
    @journeys.push(@current_journey)
  end

  def reset_journey
    @current_journey = {}
    @entry_station = nil
  end

end
