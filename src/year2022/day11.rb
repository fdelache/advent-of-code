module Year2022
  class Day11
    class Item
      attr_reader :value, :path, :id

      @@count = 0
      def initialize(value)
        @id = @@count
        @@count += 1

        @value = value
        @path = []
      end

      def add_path(monkey_id)
        @path << monkey_id
      end

      def update_value(new_value)
        @value = new_value
      end

      def transform(operation, divide = true)
        old = @value
        @value = operation.call(old)
        @value = @value / 3 if divide
      end
    end

    class Monkey
      def self.parse(input, divide = true)
        init = input.split("\n").reduce({}) do |elements, line|
          case line
          when /^Monkey (\d+):$/
            elements[:monkey] = $1.to_i
          when /Starting items: (.*)/
            elements[:items] = $1.split(",").map(&:to_i).map { Item.new(_1) }
          when /Operation: new = old \* old/
            elements[:klass] = MonkeySquare
          when /Operation: new = old \* (\d+)/
            elements[:klass] = MonkeyMultiply
            elements[:operation_value] = $1.to_i
          when /Operation: new = old \+ (\d+)/
            elements[:klass] = MonkeyAdd
            elements[:operation_value] = $1.to_i
          when /Test: divisible by (\d+)/
            elements[:modulo] = $1.to_i
          when /If true: throw to monkey (\d+)/
            elements[:throw_to_if_true] = $1.to_i
          when /If false: throw to monkey (\d+)/
            elements[:throw_to_if_false] = $1.to_i
          end
          elements
        end

        init[:divide] = divide

        klass = init.delete(:klass)
        klass.new(**init)
      end

      attr_reader :items, :throw_count, :modulo

      def initialize(monkey:, items:, operation_value: nil, modulo:, throw_to_if_true:, throw_to_if_false:, divide: true)
        @monkey = monkey
        @items = items
        @throw_count = 0

        @operation_value = operation_value
        @divide = divide
        @modulo = modulo
        @throw_to_if_true = throw_to_if_true
        @throw_to_if_false = throw_to_if_false
      end

      def turn(monkeys, super_divisor)
        @items.size.times do
          item = @items.shift
          execute(item, monkeys, super_divisor)
        end
      end

      def execute(item, monkeys, super_divisor)
        new = apply_operation(item.value)
        new /= 3 if @divide
        new = new % super_divisor

        item.update_value(new)

        if item.value % @modulo == 0
          monkeys[@throw_to_if_true].push(item)
        else
          monkeys[@throw_to_if_false].push(item)
        end

        @throw_count += 1
      end

      def push(item)
        @items.push(item)
      end

      def apply_operation(value)
        value
      end
    end

    class MonkeySquare < Monkey
      def apply_operation(value)
        value * value
      end
    end

    class MonkeyMultiply < Monkey
      def apply_operation(value)
        value * @operation_value
      end
    end

    class MonkeyAdd < Monkey
      def apply_operation(value)
        value + @operation_value
      end
    end

    def part1(input)
      monkeys = input.split("\n\n").map { Monkey.parse(_1) }

      super_divisor = monkeys.map(&:modulo).reduce(&:*)

      20.times do  |round|
        monkeys.each do |monkey|
          monkey.turn(monkeys, super_divisor)
        end
      end

      monkeys.map(&:throw_count).max(2).reduce(&:*)
    end

    def part2(input)
      monkeys = input.split("\n\n").map { Monkey.parse(_1, false) }

      super_divisor = monkeys.map(&:modulo).reduce(&:*)

      10000.times do  |round|
        monkeys.each do |monkey|
          monkey.turn(monkeys, super_divisor)
        end


        puts "Round #{round}" if round % 100 == 0
      end

      monkeys.map(&:throw_count).max(2).reduce(&:*)
    end
  end
end
