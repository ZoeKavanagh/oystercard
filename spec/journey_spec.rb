require 'journey'

describe Journey do
  let(:station) { double :station, name: :morden}
  let(:station2) { double :station2, name: :aldgate}
  describe '#start' do
    it 'should store station name in entry station' do
      expect { subject.start(station) }.to change { subject.entry_station }.to eq :morden
    end
  end

  describe '#finish' do
    it 'should store station name in exit station' do
      expect { subject.finish(station2) }.to change { subject.exit_station }.to eq :aldgate
    end
  end

  describe '#complete?' do
    it 'should return true if journey is complete' do
      subject.start(station)
      subject.finish(station2)
      expect(subject.complete?).to be true
    end
    it 'should return false if start is called twice' do
      subject.start(station)
      subject.start(station)
      expect(subject.complete?).to be false
    end
    it 'should return false if only finish called' do
      subject.finish(station2)
      expect(subject.complete?).to be false
    end
  end

  describe '#fare' do
    it 'should return penalty fare if journey is not complete' do
      subject.stub(:complete?) { false }
      expect(subject.fare).to eq Journey::PENALTY_CHARGE
    end
    it 'should return the minimum charge if journey is complete' do
      subject.stub(:complete?) { true }
      expect(subject.fare).to eq Journey::MINIMUM_CHARGE
    end
  end

end
