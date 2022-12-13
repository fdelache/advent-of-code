require 'spec_helper'

RSpec.describe Year2022::Day11 do
  let(:sample) {<<-EOF
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
  EOF
  }

  it "solves part1" do
    d = Year2022::Day11.new
    expect(d.part1(sample)).to eq(10605)
  end

  it "solves part2" do
    d = Year2022::Day11.new
    expect(d.part2(sample)).to eq(2713310158)
  end
end
