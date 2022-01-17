require 'spec_helper'

RSpec.describe Year2021::Day23 do
  let(:sample) {<<-EOF
  EOF
  }

  it "solves part1" do
    d = Year2021::Day23.new
    expect(d.part1(sample)).to eq('expected_result')
  end

  it "solves part2" do
    d = Year2021::Day23.new
    expect(d.part2(sample)).to eq(nil)
  end
end
