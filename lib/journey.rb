class Journey
  attr_reader :entrance, :eXit, :trip

  def initialize(entry = nil, eXit = nil)
    @entrance = entry
    @eXit = eXit
  end

  def record_journey
    @trip = { @entrance => @eXit }
  end
end
