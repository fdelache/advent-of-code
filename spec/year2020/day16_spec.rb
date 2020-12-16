require 'spec_helper'

RSpec.describe Year2020::Day16 do
  let(:sample) {
    <<EOF
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
EOF
  }

  let (:sample2) {
    <<EOF
class: 0-1 or 4-19
departure_row: 0-5 or 8-19
departure_seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
EOF
  }

  it "solves part1" do
    d = Year2020::Day16.new
    expect(d.part1(sample)).to eq(71)
  end

  it "solves part2" do
    d = Year2020::Day16.new
    expect(d.part2(sample2)).to eq(143)
  end
end
