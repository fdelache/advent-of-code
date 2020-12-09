require 'spec_helper'

RSpec.describe Year2020::Day09 do
  let(:sample) { <<EOF
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
EOF
}
  it "solves part1" do
    d = Year2020::Day09.new(preambule_size: 5)
    expect(d.part1(sample)).to eq(127)
  end

  it "solves part2" do
    d = Year2020::Day09.new(preambule_size: 5)
    expect(d.part2(sample)).to eq(62)
  end
end
