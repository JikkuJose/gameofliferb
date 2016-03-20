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

    def xtest_itteration
      r = GoJek::Runner.new
      r.run
    end

    def test_parse
      r = Runner.new
      r.parse

      assert_equal @parsed, r.initial_state
    end

    def test_read
      assert_equal @runner.input, @sample_input
    end

    def test_gol
      assert_equal GameOfLife::Generation.new(@parsed).next, GameOfLife::Generation.new(@next_state)
    end
  end
end

Minitest.autorun
