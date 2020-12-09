module Year2020
  class Day08
    class Cpu
      def initialize
        @accumulator = 0
        @current_line = 0
        @executed_lines = []
      end

      def execute(program)
        until @executed_lines.include?(@current_line) do
          @executed_lines << @current_line
          @current_line += execute_instruction(*program[@current_line])
        end

        @accumulator
      end

      def execute_until_end(program)
        until @executed_lines.include?(@current_line) || @current_line >= program.length do
          @executed_lines << @current_line
          @current_line += execute_instruction(*program[@current_line])
        end

        [@current_line == program.length, @accumulator]
      end

      def execute_instruction(opcode, value)
        integer_value = value.to_i
        case opcode
        when "nop"
          1
        when "acc"
          @accumulator += integer_value
          1
        when "jmp"
          integer_value
        end
      end
    end

    def part1(input)
      program = input.split("\n").map(&:split)
      Cpu.new.execute(program)
    end

    def part2(input)
      program = input.split("\n").map(&:split)

      program.each_with_index do |(opcode, value), index|
        next unless %w(nop jmp).include?(opcode)
        altered_program = program.dup
        altered_program[index] = altered_program[index].dup
        altered_program[index][0] = opcode == "nop" ? "jmp" : "nop"
        program_ended, accumulator = Cpu.new.execute_until_end(altered_program)
        return accumulator if program_ended
      end
    end
  end
end
