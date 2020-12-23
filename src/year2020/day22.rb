module Year2020
  class Day22
    class Player
      attr_reader :id, :deck

      def self.parse(input)
        data = input.split("\n")
        /Player (?<id>\d+):/ =~ data.shift

        deck = data.map(&:to_i)
        Player.new(id, deck)
      end

      def initialize(id, deck)
        @id = id
        @deck = deck
      end

      def score
        deck.reverse.each.with_index.sum { |card, index| card * (index + 1) }
      end
    end

    class Game
      attr_reader :player1, :player2

      def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
      end

      def play_round
        card1 = player1.deck.shift
        card2 = player2.deck.shift

        if card1 > card2
          player1.deck.push(card1, card2)
        else
          player2.deck.push(card2, card1)
        end
      end

      def game_ended?
        player1.deck.empty? || player2.deck.empty?
      end

      def winner
        return player1 if player2.deck.empty?
        return player2 if player1.deck.empty?
      end
    end

    class RecursiveGame
      attr_reader :deck1, :deck2, :deck1_history, :deck2_history

      def self.new_game(deck1, deck2)
        @game_number ||= 0
        @game_number += 1

        RecursiveGame.new(@game_number, deck1, deck2)
      end

      def initialize(game_number, deck1, deck2)
        @game_number = game_number
        @deck1 = deck1.dup
        @deck2 = deck2.dup

        @deck1_history = []
        @deck2_history = []
        @round = 0
      end

      def play
        puts "=== Game #{@game_number} ==="
        winner = nil
        (winner = play_round) while winner.nil?

        puts "Winner Game #{@game_number}: #{winner}"
        winner
      end

      def play_round
        @round += 1
        puts "-- Round #{@round} (Game #{@game_number}) --"
        # STDIN.gets.chomp

        return 1 if already_seen_decks?

        @deck1_history << deck1.dup
        @deck2_history << deck2.dup

        puts "Player 1's deck: #{deck1.join(", ")}"
        puts "Player 2's deck: #{deck2.join(", ")}"

        card1 = deck1.shift
        card2 = deck2.shift

        puts "Player 1 plays: #{card1}"
        puts "Player 2 plays: #{card2}"

        round_winner = if deck1.size >= card1 && deck2.size >= card2
          RecursiveGame.new_game(deck1.slice(0, card1), deck2.slice(0, card2)).play
        else
          card1 > card2 ? 1 : 2
        end

        puts "Player #{round_winner} wins round #{@round} of game #{@game_number}!"
        puts

        if round_winner == 1
          deck1.push(card1, card2)
        else
          deck2.push(card2, card1)
        end

        return nil unless game_ended?
        deck1.empty? ? 2 : 1
      end

      def already_seen_decks?
        @deck1_history.include?(deck1) && @deck2_history.include?(deck2)
      end

      def game_ended?
        deck1.empty? || deck2.empty?
      end

      def winner_score
        winning_deck = if deck2.empty?
          deck1
        else
          deck2
        end

        winning_deck.reverse.each.with_index.sum { |card, index| card * (index + 1) }
      end
    end

    def part1(input)
      players_raw = input.split("\n\n")
      player1, player2 = players_raw.map { |p| Player.parse(p) }

      game = Game.new(player1, player2)
      until game.game_ended?
        game.play_round
      end

      game.winner_score
    end

    def part2(input)
      players_raw = input.split("\n\n")
      player1, player2 = players_raw.map { |p| Player.parse(p) }

      game = RecursiveGame.new_game(player1.deck, player2.deck)
      game.play
      game.winner_score
    end
  end
end
