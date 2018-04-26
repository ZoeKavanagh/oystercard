require_relative 'journey.rb'

class Oystercard
  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :list_of_journeys, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @list_of_journeys = []
    @journey = journey
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def touch_in(entry_station)
    raise 'Insufficient funds for a journey' if balance < MINIMUM_BALANCE
    penalty_check
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.fare)
    @list_of_journeys << { @journey.entry_station => @journey.exit_station }
    @journey = Journey.new
  end

  def penalty_check
    if @journey.entry_station
      deduct(journey.fare)
      @list_of_journeys << { @journey.entry_station => nil }
    end
  end

private

  def deduct(amount)
    "Your total balance is £#{@balance -= amount}"
  end

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end
end
