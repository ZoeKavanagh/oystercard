require 'oystercard'

class Journey
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

attr_reader :entry_station, :exit_station


  def start(station)
    @entry_station = station.name
  end

  def finish(station)
    @exit_station = station.name
  end

  def complete?
     !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    complete? ? MINIMUM_CHARGE : PENALTY_CHARGE
  end

end
