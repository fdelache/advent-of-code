require 'spec_helper'

RSpec.describe Year2024::Day03 do
  let(:sample) do
    <<~EOF
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    EOF
  end

  let(:sample2) do
    <<~EOF
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    EOF
  end

  it 'solves part1' do
    d = Year2024::Day03.new
    expect(d.part1(sample)).to eq(161)
  end

  it 'solves part2' do
    d = Year2024::Day03.new
    expect(d.part2(sample2)).to eq(48)
  end
end
