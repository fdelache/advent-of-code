require 'spec_helper'

RSpec.describe Year2022::Day14 do
  let(:sample) {<<-EOF
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
  EOF
  }

  it "solves part1" do
    d = Year2022::Day14.new
    expect(d.part1(sample)).to eq(24)
  end

  it "solves part2" do
    d = Year2022::Day14.new
    expect(d.part2(sample)).to eq(93)
  end
end
