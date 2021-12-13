require 'spec_helper'

RSpec.describe Year2021::Day12 do
  let(:sample1) {<<-EOF
start-A
start-b
A-c
A-b
b-d
A-end
b-end
  EOF
  }

  let(:sample2) {<<-EOF
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
  EOF
  }

  let(:sample3) {<<-EOF
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
  EOF
  }

  it "solves part1" do
    d = Year2021::Day12.new
    expect(d.part1(sample1)).to eq(10)
    expect(d.part1(sample2)).to eq(19)
    expect(d.part1(sample3)).to eq(226)
  end

  it "solves part2" do
    d = Year2021::Day12.new
    expect(d.part2(sample2)).to eq(103)
    expect(d.part2(sample3)).to eq(3509)
  end
end
