module Year2020
  class Day23
    class Cups
      def self.parse(input)
        Cups.new(input.chomp.each_char.map(&:to_i))
      end

      attr_reader :cups, :current_cup_index, :size, :min, :max
      attr_accessor :current_cup_index

      def initialize(cups)
        @cups = cups
        @size = cups.size
        @current_cup_index = 0
        @min, @max = @cups.minmax
      end

      def current_cup
        cups[current_cup_index]
      end

      def pick_up(quantity = 3)
        quantity.times.map do
          if (current_cup_index + 1) < cups.size
            cups.delete_at(current_cup_index + 1)
          else
            self.current_cup_index -= 1
            cups.delete_at(0)
          end
        end
      end

      def destination_index
        destination_cup_number = cups[current_cup_index] - 1
        while (index = cups.find_index(destination_cup_number)).nil?
          destination_cup_number -= 1
          destination_cup_number = max if destination_cup_number < min
        end

        index
      end

      def insert(cups, index)
        self.cups.insert(index + 1, *cups)
        self.current_cup_index += cups.size if current_cup_index > index
      end

      def move
        puts "cups: #{cups.slice(0..20).to_s}..#{cups.slice(-10..-1).to_s}"
        puts "current cup index: #{current_cup_index} (value: #{cups[current_cup_index]})"
        picked = pick_up
        puts "pick up: #{picked.to_s}"
        puts "destination: #{cups[destination_index]} (index: #{destination_index + 3})"
        insert(picked, destination_index)
        self.current_cup_index = (current_cup_index + 1) % size
      end

      def label
        split_by(cups) { |c| c == 1 }.reverse.map(&:join).map(&:to_s).join
      end

      def split_by(array)
        result = [a=[]]
        array.each{ |o| yield(o) ? (result << a=[]) : (a << o) }
        result.pop if a.empty?
        result
      end
    end

    attr_reader :turns

    def initialize(turns = 100)
      @turns = turns
    end

    def part1(input)
      cups = Cups.parse(input)

      turns.times do
        cups.move
      end

      cups.label
    end

    Cup = Struct.new(:id, :next)

    def part2(input)
      cup_numbers = input.chomp.each_char.map(&:to_i)
      start = cup_numbers.max + 1
      total_size = 1000000
      tail = Array.new(total_size - cup_numbers.size) { |index| index + start }
      previous = nil
      all_cups = {}
      head = nil
      last = nil
      (cup_numbers + tail).each do |num|
        cup = Cup.new(num, nil)
        head = cup if previous.nil?
        previous.next = cup if previous
        all_cups[num] = cup
        previous = cup
        last = cup
      end

      last.next = head
      current_cup = head

      (total_size * 10).times do |i|
        pick_up = current_cup.next
        current_cup.next = pick_up.next.next.next

        destination_cup_number = current_cup.id - 1
        destination_cup_number = total_size if destination_cup_number < 1
        destination_cup = all_cups[destination_cup_number]
        while (destination_cup == pick_up || destination_cup == pick_up.next || destination_cup == pick_up.next.next)
          destination_cup_number -= 1
          destination_cup_number = total_size if destination_cup_number < 1
          destination_cup = all_cups[destination_cup_number]
        end

        pick_up.next.next.next = destination_cup.next
        destination_cup.next = pick_up

        current_cup = current_cup.next
      end

      one_cup = all_cups[1]
      one_cup.next.id * one_cup.next.next.id
    end
  end
end
