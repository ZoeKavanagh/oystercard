require 'pry'
require './lib/oystercard.rb'
require './lib/station.rb'

card = Oystercard.new

card.top_up(10)

morden = Station.new("Morden", 5)

card.touch_in(morden)
binding.pry
card.touch_out(morden)
binding.pry
