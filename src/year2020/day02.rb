module Year2020
  class Day02
    def valid_password?(rule, password)
      range, char = rule.split(' ')
      min, max = range.split('-').map(&:to_i)
      char_count = password.count(char)
      char_count >= min && char_count <= max
    end

    def part1(input)
      password_list = input.split("\n").map { |line| line.split(':') }

      password_list.count { |rule, password| valid_password?(rule, password) }
    end

    def valid_password_new_rule?(rule, password)
      positions, char = rule.split(' ')
      position_list = positions.split('-').map(&:to_i)

      matched_chars = position_list.count { |position| password[position] == char }
      matched_chars == 1
    end

    def part2(input)
      password_list = input.split("\n").map { |line| line.split(':') }

      password_list.count { |rule, password| valid_password_new_rule?(rule, password) }
    end
  end
end
