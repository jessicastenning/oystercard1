class Oystercard

MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(cash)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if @balance + cash > MAXIMUM_BALANCE
    @balance += cash
  end

end
