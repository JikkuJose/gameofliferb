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
        [1, 1]=>true,
        [1, 2]=>true,
        [2, 1]=>true,
        [2, 2]=>true,
      }

      @next_state = @parsed
      @runner = Runner.new(file_name: 'seed.txt')
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
