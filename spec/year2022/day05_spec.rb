require 'spec_helper'

RSpec.describe Year2022::Day05 do
  let(:sample) {<<-EOF
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
  EOF
  }

  it "solves part1" do
    d = Year2022::Day05.new
    expect(d.part1(sample)).to eq('CMZ')
  end

  it "solves part2" do
    d = Year2022::Day05.new
    expect(d.part2(sample)).to eq('MCD')
  end
end
