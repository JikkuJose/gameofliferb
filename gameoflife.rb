module GoJek
  ITERATIONS = 50

  class Runner
    attr_reader :input, :initial_state

    def initialize(file_name: 'seed.txt')
      @input = File
        .open(file_name)
        .readlines
        .map(&:chomp)
    end

    def parse
      array = input.map do |line|
        line
          .split
          .map { |c| c == "1" ? true : false }
      end

      @initial_state = {}

      array.each_with_index do |a, i|
        a.each_with_index do |value, k|
          @initial_state[[i, k]] = value
        end
      end

      @initial_state
    end

    def run
      parse

      ITERATIONS.times.reduce(@state) do |acc, index|
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
