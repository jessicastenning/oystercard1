class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + cash > MAXIMUM_BALANCE
    @balance += cash
  end

  def touch_in
    fail "balance too low, the minimum balance is £#{MINIMUM_BALANCE}" if @balance < 1
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false
  end

  private

  def deduct(fare=5)
    @balance -= fare
  end

end
