class Station

  attr_reader :station, :zone

  def initialize(station: nil, zone: nil)
    @station = station
    @zone = zone
  end
end
