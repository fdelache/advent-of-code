module Year2021
  class Day01
    def part1(input)
      numbers = input.split("\n").map(&:to_i)
      previous_deep = nil
      increase_count = 0
      numbers.each do |deep|
        if previous_deep && deep > previous_deep
          increase_count += 1
        end
        previous_deep = deep
      end

      increase_count
    end

    def part2(input)
      numbers = input.split("\n").map(&:to_i)
      numbers2 = numbers.drop(1)
      numbers3 = numbers.drop(2)

      numbers.pop(2)

      previous_deep = nil
      increase_count = 0
      numbers.zip(numbers2, numbers3).map(&:sum).each do |deep_sum|
        if previous_deep && deep_sum > previous_deep
          increase_count += 1
        end
        previous_deep = deep_sum
      end
      increase_count
    end
  end
end
