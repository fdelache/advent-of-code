module Year2020
  class Day25

    def transform(subject_number, value=1)
      value *= subject_number
      value % 20201227
    end

    def transform_in_loop(subject_number, loop_size)
      value = 1
      loop_size.times do
        value = transform(subject_number, value)
      end

      value
    end

    def find_loop_size(subject_number, public_key)
      loop_size = 0
      value = 1
      until value == public_key
        loop_size += 1
        value = transform(subject_number, value)
      end

      loop_size
    end

    def part1(input)
      card_public_key, door_public_key = input.split("\n").map(&:to_i)

      card_loop_size = find_loop_size(7, card_public_key)
      door_loop_size = find_loop_size(7, door_public_key)

      encryption_key = transform_in_loop(door_public_key, card_loop_size)
    end

    def part2(input)
      nil
    end
  end
end
