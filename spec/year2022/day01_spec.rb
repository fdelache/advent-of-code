require 'spec_helper'

RSpec.describe Year2022::Day01 do
  let(:sample) {<<~EOF
    1000
    2000
    3000
    
    4000
    
    5000
    6000
    
    7000
    8000
    9000
    
    10000
  EOF
  }

  it "solves part1" do
    d = Year2022::Day01.new
    expect(d.part1(sample)).to eq(24000)
  end

  it "solves part2" do
    d = Year2022::Day01.new
    expect(d.part2(sample)).to eq(45000)
  end
end
