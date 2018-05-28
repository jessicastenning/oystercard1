class Oystercard

MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + cash > MAXIMUM_BALANCE
    @balance += cash
  end

  def deduct(fare=5)
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
