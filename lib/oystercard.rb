class Oystercard
  ::DEFAULT_BALANCE = 0
  ::MAX_BALANCE = 90
  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "You have exceeded the #{MAX_BALANCE} limit." if @balance >= MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
