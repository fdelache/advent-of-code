module Year2020
  class Day06
    def count_anyone_answered_yes(group)
      group.split("\n").join.each_char.uniq.size
    end

    def count_everyone_answered_yes(group)
      group.split("\n").inject do |memo, person|
        (person.each_char.to_a & memo.each_char.to_a).join
      end.size
    end

    def part1(input)
      groups = input.split("\n\n")
      groups.sum { |group| count_anyone_answered_yes(group) }
    end

    def part2(input)
      groups = input.split("\n\n")
      groups.sum { |group| count_everyone_answered_yes(group) }
    end
  end
end
