module Year2020
  class Day18
    class Plus
      def self.compute(first, second)
        first.to_i + second.to_i
      end
    end

    class Mult
      def self.compute(first, second)
        first.to_i * second.to_i
      end
    end

    class Expression
      def self.parse(chars, plus_precedence = false)
        tokens = []
        accumulated_token = ""
        loop do
          c = chars.shift
          if c.nil?
            tokens << accumulated_token
            break
          elsif c.between?("0", "9")
            accumulated_token += c
          elsif c == " "
            tokens << accumulated_token
            accumulated_token = ""
          elsif c == "+"
            accumulated_token = Plus
          elsif c == "*"
            accumulated_token = Mult
          elsif c == "("
            accumulated_token = Expression.parse(chars, plus_precedence)
          elsif c == ")"
            tokens << accumulated_token
            break
          end
        end

        Expression.new(tokens, plus_precedence)
      end

      def initialize(tokens, plus_precedence)
        @tokens = tokens
        @plus_precedence = plus_precedence
      end

      def to_i
        if @plus_precedence
          while (plus_index = @tokens.find_index(Plus))
            second = @tokens.delete_at(plus_index + 1)
            operand = @tokens.delete_at(plus_index)
            first = @tokens.delete_at(plus_index - 1)
            @tokens.insert(plus_index - 1, operand.compute(first, second))
          end
          @tokens.reject { |t| t == Mult }.map(&:to_i).inject(&:*)
        else
          first = @tokens.shift
          until @tokens.empty?
            operand = @tokens.shift
            second = @tokens.shift
            first = operand.compute(first, second)
          end

          first
        end
      end
    end
    def part1(input)
      input.split("\n").sum do |line|
        Expression.parse(line.each_char.to_a).to_i
      end
    end

    def part2(input)
      input.split("\n").sum do |line|
        Expression.parse(line.each_char.to_a, true).to_i
      end
    end
  end
end
