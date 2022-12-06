module Year2022
  class Day05
    def part1(input)
      initial, instructions = input.split("\n\n")
      stacks = parse(initial)
      instructions.split("\n")
        .each { execute(stacks, _1) }

      stacks.map(&:last).join
    end

    def part2(input)
      initial, instructions = input.split("\n\n")
      stacks = parse(initial)
      instructions.split("\n")
        .each { execute2(stacks, _1) }

      stacks.map(&:last).join
    end

    private

    def parse(initial)
      lines = initial.split("\n")
      lines.pop
      stacks = Array.new((lines.first.size + 1) / 4) { [] }

      lines.each do |line|
        line.chars.each_with_index do |char, index|
          next unless index % 4 == 1
          next if char == " "

          stacks[index / 4].prepend(char)
        end
      end

      stacks
    end

    def execute(stacks, instruction)
      /move (?<number>\d+) from (?<src>\d+) to (?<dest>\d+)/ =~ instruction
      stacks[dest.to_i - 1].push(*stacks[src.to_i - 1].pop(number.to_i).reverse)
    end

    def execute2(stacks, instruction)
      /move (?<number>\d+) from (?<src>\d+) to (?<dest>\d+)/ =~ instruction
      stacks[dest.to_i - 1].push(*stacks[src.to_i - 1].pop(number.to_i))
    end
  end
end
