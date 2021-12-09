module Year2021
  class Day08
    class NoteEntry
      def self.parse(line)
        patterns, outputs = *(line.split("|"))
        new(patterns.split(" "), outputs.split(" "))
      end

      def initialize(patterns, outputs)
        @patterns = patterns
        @outputs = outputs

        @segments = solve_segments
      end

      def solve_segments
        patterns_by_length = @patterns.group_by(&:length)
        zero_six_nine = patterns_by_length[6]
        one = patterns_by_length[2].first
        two_three_five = patterns_by_length[5]
        four = patterns_by_length[4].first
        seven = patterns_by_length[3].first
        height = patterns_by_length[7].first

        segments = Hash.new

        # solve segment 'c'
        six = zero_six_nine.find { |p| (one.chars - p.chars).length == 1 }
        segments['c'] = (one.chars - six.chars).first

        # solve segment 'f'
        segments['f'] = (one.chars - [segments['c']]).first

        #solve segment 'b'
        three = two_three_five.select { |p| (four.chars - p.chars).length == 1 }
                              .reject { |p| (four.chars - p.chars) == [segments['c']] }
                              .first
        segments['b'] = (four.chars - three.chars).first

        #solve segment 'd'
        segments['d'] = (four.chars - segments.values_at('b', 'c', 'f')).first

        # solve segment 'a'
        segments['a'] = (seven.chars - segments.values_at('c', 'f')).first

        # solve segment 'e'
        e_g = height.chars - segments.values.compact
        segments['e'] = (two_three_five.map { |p| (e_g - p.chars) }.find { |c| c.length == 1 } ).first

        # solve segment 'g'
        segments['g'] = (height.chars - segments.values.compact).first

        segments
      end

      DIGITS = {
        'abcefg' => 0,
        'cf' => 1,
        'acdeg' => 2,
        'acdfg' => 3,
        'bcdf' => 4,
        'abdfg' => 5,
        'abdefg' => 6,
        'acf' => 7,
        'abcdefg' => 8,
        'abcdfg' => 9
      }

      def numbers
        @outputs.map do |o|
          DIGITS[o.tr(@segments.values.join, @segments.keys.join).chars.sort.join]
        end
      end
    end

    def part1(input)
      entries = input.split("\n").map { |line| NoteEntry.parse(line) }

      entries.flat_map(&:numbers).count { |num| [1, 4, 7, 8].include?(num) }
    end

    def part2(input)
      entries = input.split("\n").map { |line| NoteEntry.parse(line) }
      entries.map(&:numbers).map(&:join).map(&:to_i).sum
    end
  end
end
