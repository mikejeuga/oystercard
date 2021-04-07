require "oystercard"

describe Oystercard do
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

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "can touch out" do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end
