require 'spec_helper'

RSpec.describe Year2022::Day12 do
  let(:sample) {<<-EOF
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
  EOF
  }

  it "solves part1" do
    d = Year2022::Day12.new
    expect(d.part1(sample)).to eq(31)
  end

  it "solves part2" do
    d = Year2022::Day12.new
    expect(d.part2(sample)).to eq(29)
  end
end
