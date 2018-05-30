require 'station'

describe Station do

  subject {described_class.new(station: "Bank", zone: 1)}

  it 'should know the station name' do
    expect(subject.station).to eq "Bank"
  end
  it 'should know the zone number' do
    expect(subject.zone).to eq 1
  end
end
