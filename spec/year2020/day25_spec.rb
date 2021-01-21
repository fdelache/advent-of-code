require 'spec_helper'

RSpec.describe Year2020::Day25 do
  let(:sample) {
    <<EOF
5764801
17807724
EOF
  }

  it "solves part1" do
    d = Year2020::Day25.new
    expect(d.part1(sample)).to eq(14897079)
  end

  it "solves part2" do
    d = Year2020::Day25.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
