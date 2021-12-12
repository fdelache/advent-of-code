module Year2021
  class Day11
    class Octopus
      def initialize(energy)
        @energy = energy
      end

      def increase_energy
        @energy += 1 if @energy <= 9
      end

      def reset_flashed
        @energy = 0 if @energy > 9
      end

      def flashed?
        @energy > 9
      end

      def energy
        @energy
      end
    end

    class Steps
      def initialize(input)
        @octopuses = {}

        input.split.each_with_index do |row, x|
          row.each_char.each_with_index do |energy, y|
            @octopuses[[x,y]] = Octopus.new(energy.to_i)
          end
        end

        @flashed_count = 0
        @step = 0
      end

      def print
        puts "After step #{@step}"
        (0...10).each do |x|
          (0...10).each do |y|
            putc @octopuses[[x,y]].energy.to_s
          end
          puts
        end
        puts
      end

      def step_number
        @step
      end

      def step
        @octopuses.values.each(&:increase_energy)
        process_flashes(@octopuses.keys)

        @flashed_count += @octopuses.values.count(&:flashed?)
        @octopuses.values.each(&:reset_flashed)

        @step += 1
        # print
      end

      def flashed_count
        @flashed_count
      end

      def all_flashed?
        @octopuses.values.all? { |o| o.energy == 0 }
      end

      def process_flashes(positions, flashed = [])
        return if positions.empty?

        flashing = positions.reject { |pos| flashed.include?(pos) }
                            .reject { |pos| @octopuses[pos].nil? }
                            .filter { |pos| @octopuses[pos].energy > 9 }
        flashed.push(*flashing)

        adjacents = flashing.flat_map do |pos|
          adjacent_positions(pos).filter_map do |adjacent_pos|
            @octopuses[adjacent_pos]&.increase_energy
            adjacent_pos
          end
        end.uniq

        process_flashes(adjacents, flashed)
      end

      def adjacent_positions(pos)
        deltas = (-1..1).to_a.repeated_permutation(2).reject { |x, y| x==0 && y==0 }
        deltas.map { |dx, dy| [pos[0] + dx, pos[1] + dy] }
      end
    end

    def part1(input)
      steps = Steps.new(input)
      steps.print

      100.times do |i|
        steps.step
      end

      steps.flashed_count
    end

    def part2(input)
      steps = Steps.new(input)
      steps.print

      until steps.all_flashed?
        steps.step
      end

      steps.step_number
    end
  end
end
