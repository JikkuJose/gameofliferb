module GoJek
  ITERATIONS = 50

  class Runner
    attr_reader :input, :initial_state

    def initialize(file_name: 'seed.txt')
      @input = File
        .open(file_name)
        .readlines
        .map(&:chomp)

      @initial_state = {}
      @initial_state.default = false
    end

    def parse
      array = @input.map do |line|
        line
          .split
          .map { |c| c == "1" ? true : false }
      end

      @input_width = array.first.size
      @input_height = array.size

      array.each_with_index do |row, i|
        row.each_with_index do |value, k|
          @initial_state[[i, k]] = value
        end
      end

      @initial_state.reject! do |_, value|
        value == false
      end
    end

    def run
      parse

      @output = ITERATIONS
        .times
        .inject(GameOfLife::Generation.new(initial_state)) do |gen, index|
        gen.next
      end

      print
    end

    def print
      row_min = @output.state.keys.map { |row, _| row }.min
      column_min = @output.state.keys.map { |_, column| column }.min

      row_max = @output.state.keys.map { |row, _| row }.max
      column_max = @output.state.keys.map { |_, column| column }.max

      strings = (row_min..row_max).map do |i|
        (column_min..column_max).map do |k|
          @output.state[[i, k]] ? "1" : 0
        end
          .join(" ")
      end

      padded_string = strings
        .map { |string| "0 " + string + " 0" }

      horizontal_pad = ("0 " * (column_max - column_min + 3)).strip

      puts [
        horizontal_pad,
        padded_string,
        horizontal_pad
      ].join("\n")
    end
  end

  module GameOfLife
    class Generation
      attr_reader :state

      def initialize(state)
        @state = state
        @state.default = false

        @new_state = {}
        @new_state.default = false
      end

      def next
        @state.each do |c, value|
          ([c] + surroundings(c)).each do |coordinate|
            @new_state[coordinate] = case neighbour_count(coordinate)
                                     when 2
                                       @state[coordinate]
                                     when 3
                                       true
                                     else
                                       false
                                     end
          end
        end

        self.class.new(@new_state.reject! { |_, v| v == false })
      end

      def ==(other)
        @state == other.state
      end

      def surroundings(c)
        grid_mask.map do |x, y|
          [c[0] + x, c[1] + y]
        end
      end

      def grid_mask
        [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
      end

      def neighbour_count(coordinate)
        grid_mask.count do |x, y|
          @state[[coordinate[0] + x, coordinate[1] + y]] == true
        end
      end
    end
  end
end
