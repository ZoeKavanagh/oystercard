

class Oystercard
  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :list_of_journeys, :entry_station, :exit_station

  def initialize
    @balance = 0
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def touch_in(entry_station)
    raise 'Insufficient funds for a journey' if balance < MINIMUM_BALANCE
    @entry_station = entry_station.name
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @exit_station = exit_station.name
    @list_of_journeys << { @entry_station => @exit_station }
    @entry_station, @exit_station  = nil
  end

  def in_journey?
      !@entry_station.nil?
  end

private

  def deduct(amount)
    "Your total balance is £#{@balance -= amount}"
  end

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
