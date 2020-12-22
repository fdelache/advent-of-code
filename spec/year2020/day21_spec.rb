require 'spec_helper'

RSpec.describe Year2020::Day21 do
  let(:sample) {
    <<EOF
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
EOF
  }

  it "solves part1" do
    d = Year2020::Day21.new
    expect(d.part1(sample)).to eq(5)
  end

  it "solves part2" do
    d = Year2020::Day21.new
    expect(d.part2(sample)).to eq('mxmxvkd,sqjhc,fvjkl')
  end
end
