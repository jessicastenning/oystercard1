class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(cash)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + cash > MAXIMUM_BALANCE
    @balance += cash
  end

  def touch_in(entry_station)
    fail "balance too low, the minimum balance is £#{MINIMUM_BALANCE}" if @balance < 1
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(fare=5)
    @balance -= fare
  end

end
