module Year2022
  class Day02
    def part1(input)
      input.split("\n")
        .map { |play| score(play) }
        .sum
    end

    def part2(input)
      input.split("\n")
        .map { |play| score_with_outcome(play) }
        .sum
    end

    private

    def score(play)
      opponent, you = play.split(" ")
      POINTS[you] + outcome(opponent, you)
    end

    def score_with_outcome(play)
      opponent, outcome = play.split(" ")
      game = game_for_outcome(opponent, outcome)
      POINTS[game.you] + game.score
    end

    Game = Struct.new(:opponent, :you, :score)

    GAMES = [
      Game.new("A", "X", 3),
      Game.new("A", "Y", 6),
      Game.new("A", "Z", 0),
      Game.new("B", "X", 0),
      Game.new("B", "Y", 3),
      Game.new("B", "Z", 6),
      Game.new("C", "X", 6),
      Game.new("C", "Y", 0),
      Game.new("C", "Z", 3),
    ]

    POINTS = {
      "X" => 1,
      "Y" => 2,
      "Z" => 3
    }

    def outcome(opponent, you)
      GAMES.find { |game| game.opponent == opponent && game.you == you }.score
    end

    def game_for_outcome(opponent, outcome)
      expected_score = case outcome
      when "X" then 0
      when "Y" then 3
      when "Z" then 6
      end

      GAMES.find { |game| game.opponent == opponent && game.score == expected_score }
    end
  end
end
