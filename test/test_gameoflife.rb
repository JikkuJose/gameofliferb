require 'minitest'
require 'minitest/reporters'
require_relative '../gameoflife.rb'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({detailed_skip: false})]

module GoJek
  class RunnerTest < Minitest::Test
    def setup
      @sample_input = [
        "0 0 0 0",
        "0 1 1 0",
        "0 1 1 0",
        "0 0 0 0"
      ]

      @parsed = {
        [0, 0]=>false,
        [0, 1]=>false,
        [0, 2]=>false,
        [0, 3]=>false,
        [1, 0]=>false,
        [1, 1]=>true,
        [1, 2]=>true,
        [1, 3]=>false,
        [2, 0]=>false,
        [2, 1]=>true,
        [2, 2]=>true,
        [2, 3]=>false,
        [3, 0]=>false,
        [3, 1]=>false,
        [3, 2]=>false,
        [3, 3]=>false
      }

      @next_state = @parsed
      @runner = Runner.new(file_name: 'seed.txt')
    end

    def test_parse
      @runner.parse
      assert_equal @runner.initial_state, @parsed
    end

    def test_read
      assert_equal @runner.input, @sample_input
    end

    def test_gol
      assert_equal GameOfLife.new(@parsed).next, @next_state
    end
  end
end

Minitest.autorun
