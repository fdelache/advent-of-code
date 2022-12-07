require 'spec_helper'

RSpec.describe Year2022::Day07 do
  let(:sample) {<<-EOF
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
  EOF
  }

  it "solves part1" do
    d = Year2022::Day07.new
    expect(d.part1(sample)).to eq(95437)
  end

  it "solves part2" do
    d = Year2022::Day07.new
    expect(d.part2(sample)).to eq(24933642)
  end
end
