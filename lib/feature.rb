require 'pry'
require_relative 'oystercard.rb'
require_relative 'station.rb'
require_relative 'journey.rb'

card = Oystercard.new

card.top_up(15)

morden = Station.new("Morden", 5)
algate = Station.new("Algate", 2)

card.touch_in(morden)
card.touch_out(algate)
card.touch_in(morden)
card.touch_out(algate)
card.touch_in(morden)
card.touch_out(algate)
card.touch_out(algate)
card.touch_in(morden)
card.touch_in(morden)
binding.pry
