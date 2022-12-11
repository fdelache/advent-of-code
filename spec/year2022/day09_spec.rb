require 'spec_helper'

RSpec.describe Year2022::Day09 do
  let(:sample) {<<-EOF
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
  EOF
  }

  let(:sample2) {<<-EOF
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
  EOF
  }

  let(:sample3) {<<-EOF
R 1
U 1
R 1
U 1
R 1
U 1
R 1
U 1
R 1
U 1
  EOF
  }

  it "solves part1" do
    d = Year2022::Day09.new
    expect(d.part1(sample)).to eq(13)
  end

  it "solves part2" do
    d = Year2022::Day09.new
    expect(d.part2(sample)).to eq(1)
  end

  it "solves part2 with larger sample" do
    d = Year2022::Day09.new
    expect(d.part2(sample2)).to eq(36)
  end

  it "solves part2 with sample3" do
    d = Year2022::Day09.new
    expect(d.part2(sample3)).to eq(1)
  end
end
