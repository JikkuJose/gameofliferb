module GoJek
  ITERATIONS = 50

  class Runner
    attr_reader :input

    def initialize(file_name: 'seed.txt')
      @input = File
        .open(file_name)
        .readlines
        .map(&:chomp)
    end

    def initial_state
      array = input.map do |line|
        line
          .split
          .map { |c| c == "1" ? true : false }
      end

      array.each_with_index.flat_map do |a, i|
        a.each_with_index.map do |value, k|
          next unless value
          [i, k]
        end
      end
        .compact
    end

    def run
      parse

      ITERATIONS.times.reduce(initial_state) do |acc, index|
        GameOfLife.new(acc).next
      end
    end
  end

  class GameOfLife
    def initialize(state)
      @state = state
    end

    def next
      @state
    end
  end
end
