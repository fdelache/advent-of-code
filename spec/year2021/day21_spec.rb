require 'spec_helper'

RSpec.describe Year2021::Day21 do
  let(:sample) {<<-EOF
Player 1 starting position: 4
Player 2 starting position: 8
  EOF
  }

  it "solves part1" do
    d = Year2021::Day21.new
    expect(d.part1(sample)).to eq(739785)
  end

  it "solves part2" do
    d = Year2021::Day21.new
    expect(d.part2(sample)).to eq(444356092776315)
  end
end
