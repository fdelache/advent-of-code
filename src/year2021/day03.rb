module Year2021
  class Day03
    def part1(input)
      report = input.split

      digits_length = report.first.length
      accumulated_sum = Array.new(digits_length, 0)

      report.each do |binary|
        binary.each_char.with_index do |b, i|
          accumulated_sum[i] += b.to_i
        end
      end

      # If the sum is larger than half the count of entries in the report, then it's `1` that is the most frequent one.
      gamma_rate = accumulated_sum.map { |s| s > (report.length/2) ? "1" : "0" }.join.to_i(2)
      epsilon_rate = accumulated_sum.map { |s| s <= (report.length/2) ? "1" : "0" }.join.to_i(2)

      gamma_rate * epsilon_rate
    end

    def part2(input)
      report = input.split

      digits_length = report.first.length
      oxygen_generator = report
      digits_length.times do |i|
        bit = most_common_bit(oxygen_generator, i)
        oxygen_generator = oxygen_generator.filter { |number| number[i] == bit }

        break if oxygen_generator.size == 1
      end

      oxygen_generator = oxygen_generator.first.to_i(2)

      co2_scrubber = report
      digits_length.times do |i|
        bit = most_common_bit(co2_scrubber, i)
        co2_scrubber = co2_scrubber.filter { |number| number[i] != bit }

        break if co2_scrubber.size == 1
      end

      co2_scrubber = co2_scrubber.first.to_i(2)

      oxygen_generator * co2_scrubber
    end

    def most_common_bit(numbers_as_string, position)
      sum_bits = numbers_as_string.map(&:each_char).map(&:to_a).transpose.map { |digits| digits.map(&:to_i).sum }
      (2 * sum_bits[position]) >= numbers_as_string.length ? "1" : "0"
    end
  end
end
