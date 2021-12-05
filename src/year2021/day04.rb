module Year2021
  class Board
    def initialize(strings)
      @number_grid = strings.map(&:split).map { |row| row.map(&:to_i) }
      @numbers = @number_grid.flatten
      @marked = Array.new(5) { |index| Array.new(5, false) }
    end

    def win?
      @marked.any? { |row| row.all? } || @marked.transpose.any? { |col| col.all? }
    end

    def unmarked_sum
      sum = 0
      @marked.each_with_index do |row, y|
        row.each_with_index do |marked, x|
          sum += @number_grid[y][x] unless marked
        end
      end

      sum
    end

    def draw_number(number)
      return unless (number_index = @numbers.index(number))

      row, col = [number_index / 5, number_index % 5]

      @marked[row][col] = true
    end
  end

  class Bingo
    def initialize(input)
      input = input.split("\n")
      @numbers = input.shift.split(",").map(&:to_i)
      input.reject!(&:empty?)

      @boards = input.each_slice(5).map do |board_string|
        Board.new(board_string)
      end
    end

    def play
      until winner? do
        @draw_number = @numbers.shift
        @boards.each { |board| board.draw_number(@draw_number) }
      end
    end

    def play_last_winner
      until winner? do
        @draw_number = @numbers.shift
        @boards.each { |board| board.draw_number(@draw_number) }
        @boards.reject!(&:win?) unless (@boards.size == 1)
      end
    end

    def winner?
      @boards.any?(&:win?)
    end

    def final_score
      return unless (winner = @boards.find(&:win?))

      winner.unmarked_sum * @draw_number
    end
  end

  class Day04
    def part1(input)
      game = Bingo.new(input)
      game.play
      game.final_score
    end

    def part2(input)
      game = Bingo.new(input)
      game.play_last_winner
      game.final_score
    end
  end
end
