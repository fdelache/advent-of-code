module Year2022
  class Day07
    class Directory
      attr_reader :name, :children
      attr_accessor :parent

      def initialize(name)
        @name = name
        @children = []
      end

      def size
        children.sum(&:size)
      end

      def <<(child)
        children << child
        child.parent = self
      end

      def [](name)
        children.find { _1.name == name }
      end
    end

    class File
      attr_reader :name, :size
      attr_accessor :parent

      def initialize(name, size)
        @name = name
        @size = size
      end
    end

    def part1(input)
      root = parse_folder_tree(input)

      all_folders(root).select { _1.size <= 100000 }.map(&:size).sum
    end

    def part2(input)
      disk_space = 70000000
      needed_free_space = 30000000

      root = parse_folder_tree(input)

      unused_space = disk_space - root.size
      space_to_delete = needed_free_space - unused_space
      all_folders(root).select { _1.size >= space_to_delete }.map(&:size).min
    end

    private

    def parse_folder_tree(input)
      root = Directory.new("/")

      input.split("\n")
        .slice_before(/^\$ /)
        .reduce(root) { parse_command(_2, _1) }

      root
    end

    def parse_command(console, current_folder)
      command = console.shift
      output = console

      case command
      when /^\$ cd \/$/
        while current_folder.name != "/"
          current_folder = current_folder.parent
        end
        current_folder
      when /^\$ cd \.\.$/
        current_folder.parent
      when /^\$ cd (.*)$/
        current_folder[$1]
      when /^\$ ls$/
        output.each do |line|
          case line
          when /^dir (.*)$/
            current_folder << Directory.new($1)
          when /^(\d+) (.*)$/
            current_folder << File.new($2, $1.to_i)
          end
        end
        current_folder
      end
    end

    def all_folders(folder)
      return [] if folder.is_a?(File)
      [folder] + folder.children.flat_map { all_folders(_1) }
    end
  end
end
