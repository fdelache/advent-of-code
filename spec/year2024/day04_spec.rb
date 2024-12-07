require 'spec_helper'

RSpec.describe Year2024::Day04 do
  let(:sample) do
    <<~EOF
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    EOF
  end

  it 'solves part1' do
    d = Year2024::Day04.new
    expect(d.part1(sample)).to eq(18)
  end

  it 'solves part2' do
    d = Year2024::Day04.new
    expect(d.part2(sample)).to eq(9)
  end
end
