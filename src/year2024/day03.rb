module Year2024
  class ::Array
    def multiply
      inject(1) { |acc, x| acc * x.to_i }
    end
  end

  class Day03
    def part1(input)
      input.scan(/mul\((\d+),(\d+)\)/).map(&:multiply).sum
    end

    def part2(input)
      parse_with_conditionals(input).sum
    end

    private

    def parse_with_conditionals(input)
      return to_enum(__method__, input) unless block_given?

      mul_enabled = true
      input.scan(/(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/).each do |match|
        case match[0]
        when /mul\(\d+,\d+\)/
          yield match[1].to_i * match[2].to_i if mul_enabled
        when 'do()'
          mul_enabled = true
        when 'don\'t()'
          mul_enabled = false
        end
      end
    end
  end
end
