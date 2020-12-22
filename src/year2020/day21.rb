module Year2020
  class Day21
    class Food
      attr_reader :ingredients, :allergies
      def self.parse(line)
        /^(?<ingredients>.*) \(contains (?<allergies>.*)\)/ =~ line
        Food.new(ingredients.split(" "), allergies.split(", "))
      end

      def initialize(ingredients, allergies)
        @ingredients = ingredients
        @allergies = allergies
      end
    end

    def find_mapping(foods)
      mapping = { }
      foods.each_with_object(mapping) do |food, mapping|
        food.allergies.each do |allergy|
          if mapping.has_key?(allergy)
            mapping[allergy] &= food.ingredients
          else
            mapping[allergy] = food.ingredients
          end
        end
      end

      mapping
    end

    def part1(input)
      foods = input.split("\n").map { |l| Food.parse(l) }

      mapping = find_mapping(foods)

      all_ingredients = foods.map(&:ingredients).flatten.uniq
      ingredients_with_allergy = mapping.values.flatten.uniq

      ingredients_without_allergy = all_ingredients - ingredients_with_allergy

      foods.sum { |f| f.ingredients.count { |i| ingredients_without_allergy.include?(i) } }
    end

    def part2(input)
      foods = input.split("\n").map { |l| Food.parse(l) }

      mapping = find_mapping(foods)

      puts "Ingredients wth allergies:"
      p mapping

      result = {}
      2.times do
        mapping.sort_by {|k,v| v.size}.each do |allergy, ingredients|
          ingredients = ingredients - result.values

          if ingredients.size == 1
            result[allergy] = ingredients.first
          end
        end
      end

      result.sort_by {|k,v| k }.map(&:last).join(",")
    end
  end
end
