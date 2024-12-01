require 'spec_helper'

RSpec.describe Year2024::Day01 do
  let(:sample) do
    <<~EOF
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    EOF
  end

  it 'solves part1' do
    d = Year2024::Day01.new
    expect(d.part1(sample)).to eq(11)
  end

  it 'solves part2' do
    d = Year2024::Day01.new
    expect(d.part2(sample)).to eq(31)
  end
end
