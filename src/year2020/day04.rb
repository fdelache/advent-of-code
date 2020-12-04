module Year2020
  class Day04
    class Passport
      FIELDS_RULES = {
        'byr' => ->(value) { (1920..2002).include?(value.to_i) },
        'iyr' => ->(value) { (2010..2020).include?(value.to_i) },
        'eyr' => ->(value) { (2020..2030).include?(value.to_i) },
        'hgt' => ->(value) {
          if match = value.match(/\A(?<height>\d+)(?<unit>(cm|in))\z/)
            case match[:unit]
            when "cm"
              (150..193).include?(match[:height].to_i)
            when "in"
              (59..76).include?(match[:height].to_i)
            end
          end
        },
        'hcl' => ->(value) { value.match?(/\A#[0-9a-f]{6}\z/) },
        'ecl' => ->(value) { %w(amb blu brn gry grn hzl oth).include?(value) },
        'pid' => ->(value) { value.match?(/\A\d{9}\z/) },
        'cid' => ->(value) { true }
      }.freeze

      IGNORED_FIELDS = %w[cid].freeze

      def add_field(field, value)
        @fields ||= {}
        @fields[field] = value
      end

      def has_all_required_fields?
        missing_fields = FIELDS_RULES.keys - @fields.keys
        missing_fields.empty? || (missing_fields - IGNORED_FIELDS).empty?
      end

      def all_fields_valid?
        @fields.all? { |field, value| FIELDS_RULES[field].call(value) }
      end

      def empty?
        @fields.empty?
      end
    end

    def part1(input)
      passports = parse_passports(input)
      passports.count(&:has_all_required_fields?)
    end

    def part2(input)
      passports = parse_passports(input)
      passports.filter!(&:has_all_required_fields?)
      passports.count(&:all_fields_valid?)
    end

    def parse_passports(input)
      lines = input.split("\n")

      lines.each_with_object([Passport.new]) do |line, memo|
        if line.empty?
          memo << Passport.new
        else
          line.split(' ').map { |combo| combo.split(':') }
              .each { |field, value| memo.last.add_field(field, value) }
        end
      end.reject(&:empty?)
    end
  end
end
