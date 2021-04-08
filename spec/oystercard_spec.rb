require "oystercard"

describe Oystercard do
  let (:entry_station) { double :station }

  context "#balance" do
    it "should have a balance set to 0" do
      expect(subject.balance).to eq(0)
    end
  end

  context "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should add an amount" do
      expect(subject.top_up(5)).to eq(5)
    end

    it "should increase the balance" do
      oyster = Oystercard.new
      oyster.top_up(5)
      expect(oyster.balance).to eq(5)
    end

    it "should raise an error if the balance is already at the limit" do
      max_bal = ::MAX_BALANCE
      subject.top_up(max_bal)
      expect { subject.top_up(1) }.to raise_error("You have exceeded the #{max_bal} limit.")
    end
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  context "#touch_out" do
    it "can touch out" do
      oyster = Oystercard.new(3)
      oyster.touch_in(entry_station)
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end

    it "deducts from the card on touch out" do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out }.to change { subject.balance }.by -(::MIN_FARE)
    end

    it "should nullify the entry_station" do
      subject.top_up(2)
      subject.touch_in(entry_station)
      expect { subject.touch_out }.to change { subject.entry_station }.to nil
    end

    it "a journey can be ended" do
      subject.top_up(3)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  context "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "can touch in" do
      oyster = Oystercard.new(3)
      oyster.touch_in(entry_station)
      expect(oyster).to be_in_journey
    end

    it "should record an entry station" do
      subject.top_up(3)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    it "should raise an error if not enough at least GBP1" do
      oyster = Oystercard.new
      expect { oyster.touch_in(entry_station) }.to raise_error("You don't have enough funds")
    end
  end
end
