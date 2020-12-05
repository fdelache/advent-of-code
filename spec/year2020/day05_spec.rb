require 'spec_helper'

RSpec.describe Year2020::Day05 do
  let(:sample) { <<EOF
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
EOF
  }
  it "solves part1" do
    d = Year2020::Day05.new
    expect(d.part1(sample)).to eq(820)
  end
end
