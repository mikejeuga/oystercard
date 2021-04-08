class Oystercard
  ::DEFAULT_BALANCE = 0
  ::MIN_FARE = 1
  ::MAX_BALANCE = 90
  attr_reader :balance, :entry_station, :exit_station, :journey_list

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_list = []
  end

  def top_up(amount)
    fail "You have exceeded the #{MAX_BALANCE} limit." if max_limit

    @balance += amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(entry_station)
    fail "You don't have enough funds" if min_amount
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    record_journey
    @entry_station = nil
  end

  def record_journey
    @journey_list << { @entry_station => @exit_station }
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def max_limit
    @balance >= MAX_BALANCE
  end

  def min_amount
    @balance < MIN_FARE
  end
end
