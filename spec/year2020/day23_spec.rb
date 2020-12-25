require 'spec_helper'

RSpec.describe Year2020::Day23 do
  let(:sample) {
    <<EOF
389125467
EOF
  }
  it "solves part1" do
    d = Year2020::Day23.new(10)
    expect(d.part1(sample)).to eq('92658374')

    d = Year2020::Day23.new(100)
    expect(d.part1(sample)).to eq('67384529')
  end

  it "solves part2" do
    d = Year2020::Day23.new
    expect(d.part2(sample)).to eq(nil)
  end
end
