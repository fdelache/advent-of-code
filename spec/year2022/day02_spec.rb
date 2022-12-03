require 'spec_helper'

RSpec.describe Year2022::Day02 do
  let(:sample) {<<-EOF
A Y
B X
C Z
  EOF
  }

  it "solves part1" do
    d = Year2022::Day02.new
    expect(d.part1(sample)).to eq(15)
  end

  it "solves part2" do
    d = Year2022::Day02.new
    expect(d.part2(sample)).to eq(12)
  end
end
