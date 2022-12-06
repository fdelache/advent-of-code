require 'spec_helper'

RSpec.describe Year2022::Day06 do
  let(:sample) {<<-EOF
bvwbjplbgvbhsrlpgdmjqwftvncz
  EOF
  }

  it "solves part1" do
    d = Year2022::Day06.new
    expect(d.part1(sample)).to eq(5)
  end

  it "solves part2" do
    d = Year2022::Day06.new
    expect(d.part2(sample)).to eq(23)
  end
end
