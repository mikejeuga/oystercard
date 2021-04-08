require "journey"

describe Journey do
  context "#initialize" do
    it "should have an entrance station do" do
      expect(subject.entrance).to eq(subject.entrance)
    end

    it "should have a exit station do" do
      expect(subject.eXit).to eq(subject.eXit)
    end
  end
  context "#record_jouney" do
    it "should create a journey hashe" do
      subject.record_journey
      expect(subject.trip).to eq({ @entrance => @eXit })
    end
  end
end
