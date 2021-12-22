module Year2021
  class Day21
    class Die
      attr_reader :rolled

      def initialize
        @current = 0
        @rolled = 0
      end

      def roll
        @current += 1
        @rolled += 1
        @current = 1 if @current > 100
        @current
      end
    end

    class Player
      attr_reader :score
      def initialize(id, position)
        @id = id
        self.position = position
        @score = 0
      end

      def position=(new_position)
        @position = (new_position - 1) % 10
      end

      def position
        @position + 1
      end

      def play(die)
        self.position += 3.times.map { |_| die.roll }.sum
        @score += position
      end

      def win?
        @score >= 1000
      end
    end

    class Game
      def initialize(players)
        @die = Die.new
        @win_score = 1000
        @players = players
      end

      def play
        current_player_index = 0
        until @players.any? { |p| p.score >= @win_score }
          @players[current_player_index].play(@die)
          current_player_index = (current_player_index + 1) % @players.size
        end

        @players.find { |p| !p.win? }.score * @die.rolled
      end
    end

    module GameRules
      def self.position(position, dice_sum)
        ((position + dice_sum - 1) % 10) + 1
      end
    end

    class QuantumGame
      GameState = Struct.new(:players_position, :players_score) do
        def play(playing_player, dice_sum)
          return self if ended?

          new_position = players_position.dup
          new_score = players_score.dup
          new_position[playing_player] = GameRules.position(players_position[playing_player], dice_sum)
          new_score[playing_player] += new_position[playing_player]

          GameState.new(new_position, new_score)
        end

        def ended?
          players_score.any? { |s| s >= 21 }
        end

        def winning_player
          players_score.index { |s| s >= 21 }
        end
      end

      DICE_OUTCOMES = [1,2,3].repeated_permutation(3).map(&:sum)

      attr_reader :positions
      def initialize(positions)
        @positions = positions
      end

      def play
        game_state_count = Hash.new(0)
        game_state_count[GameState.new(positions, [0] * positions.length)] = 1

        current_player = 0
        until game_state_count.keys.all?(&:ended?)
          game_state_count = game_state_count.each_with_object(Hash.new(0)) do |(game_state, game_count), new_game_state_count|
            if game_state.ended?
              new_game_state_count[game_state] += game_count
            else
              DICE_OUTCOMES.map do |dice_sum|
                new_game_state_count[game_state.play(current_player, dice_sum)] += game_count
              end
            end
          end
          current_player = (current_player + 1) % positions.length
        end

        winning_games = game_state_count.inject(Hash.new(0)) do |winning_games, (game_state, game_count)|
          winning_games[game_state.winning_player] += game_count
          winning_games
        end

        winning_games.values.max
      end
    end

    def part1(input)
      players = input.split("\n").map do |line|
        /Player (?<id>\d+) starting position: (?<position>\d+)/ =~ line
        Player.new(id, position.to_i)
      end
      Game.new(players).play
    end

    def part2(input)
      QuantumGame.new(input.split("\n").map do |line|
        /Player \d+ starting position: (?<position>\d+)/ =~ line
        position.to_i
      end).play
    end
  end
end
