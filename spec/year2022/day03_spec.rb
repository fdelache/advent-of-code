require 'spec_helper'

RSpec.describe Year2022::Day03 do
  let(:sample) {<<-EOF
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
  EOF
  }

  it "solves part1" do
    d = Year2022::Day03.new
    expect(d.part1(sample)).to eq(157)
  end

  it "solves part2" do
    d = Year2022::Day03.new
    expect(d.part2(sample)).to eq(70)
  end
end
