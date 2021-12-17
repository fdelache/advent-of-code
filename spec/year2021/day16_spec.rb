require 'spec_helper'

RSpec.describe Year2021::Day16 do
  it "solves part1" do
    d = Year2021::Day16.new
    expect(d.part1("8A004A801A8002F478")).to eq(16)
    expect(d.part1("620080001611562C8802118E34")).to eq(12)
    expect(d.part1("C0015000016115A2E0802F182340")).to eq(23)
    expect(d.part1("A0016C880162017C3686B18A3D4780")).to eq(31)
  end

  it "solves part2" do
    d = Year2021::Day16.new
    expect(d.part2("C200B40A82")).to eq(3)
    expect(d.part2("04005AC33890")).to eq(54)
    expect(d.part2("880086C3E88112")).to eq(7)
    expect(d.part2("CE00C43D881120")).to eq(9)
    expect(d.part2("D8005AC2A8F0")).to eq(1)
    expect(d.part2("F600BC2D8F")).to eq(0)
    expect(d.part2("9C005AC2F8F0")).to eq(0)
    expect(d.part2("9C0141080250320F1802104A08")).to eq(1)
  end
end
