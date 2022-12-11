require 'spec_helper'

RSpec.describe Year2022::Day08 do
  let(:sample) {<<-EOF
30373
25512
65332
33549
35390
  EOF
  }

  it "solves part1" do
    d = Year2022::Day08.new
    expect(d.part1(sample)).to eq(21)
  end

  it "solves part2" do
    d = Year2022::Day08.new
    expect(d.part2(sample)).to eq(8)
  end
end
