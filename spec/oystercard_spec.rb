require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station, name: :morden}
  let(:exit_station) { double :exit_station, name: :aldgate}

  describe '#balance' do
    it 'should return the balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#initialise' do
    it 'should have #list_of_journeys as an empty hash' do
      expect(subject.list_of_journeys).to be_empty
    end
  end


  describe '#top_up' do
    it 'should return correct balance when topped up' do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it 'should raise error if total exceeds max limit' do
      expect { oystercard.top_up(100) }.to raise_error("Cannot top up as balance exceeds maximum limit.")
    end
  end

  describe '#touch_in' do
    it 'should raise an error message if balance on #touch_in is less than £1' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds for a journey'
    end
end
  describe '#touch_out' do
    let(:journey) {double(:journey, fare: Journey::MINIMUM_CHARGE)}
    it 'should deduct minimum fare upon #touch_out' do
      subject.instance_variable_set(:@balance, 20)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Journey::MINIMUM_CHARGE)
    end
    context 'touch out affects in_journey? method' do
      before(:each) do
        subject.instance_variable_set(:@balance, 20)
        subject.touch_in(entry_station)
      end
      it 'should store exit_station on touch_out' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.list_of_journeys.last[:morden]).to eq :aldgate
      end
    end
  end

    context 'touching in and out' do
      before(:each) do
        subject.instance_variable_set(:@balance, 20)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end

      it 'should store one journey' do
        expect(subject.list_of_journeys.length).to eq 1
      end
    end

end
