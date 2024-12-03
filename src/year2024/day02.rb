module Year2024
  module ::Enumerable
    def to_i
      map(&:to_i)
    end
  end

  class Day02
    def part1(input)
      reports(input).select(&method(:safe?))
                    .count
    end

    def part2(input)
      reports(input).select(&method(:safe_with_tolerance?))
                    .count
    end

    private

    def reports(input)
      input.lines.map(&:split).map(&:to_i)
    end

    def deltas(report)
      report.each_cons(2).map { |a, b| b - a }
    end

    def safe?(report)
      deltas = deltas(report)

      return false unless deltas.all?(&:positive?) || deltas.all?(&:negative?)
      return false if deltas.any?(&:zero?)
      return false if deltas.empty?
      return false unless deltas.map(&:abs).max <= 3

      true
    end

    def safe_with_tolerance?(report)
      return true if safe?(report)

      to_enum(:alternate_reports, report).any?(&method(:safe?))
    end

    def alternate_reports(report)
      report.size.times.each do |i|
        alternate = report.dup
        alternate.delete_at(i)
        yield alternate
      end
    end
  end
end
