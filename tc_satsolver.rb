require "test/unit"
require_relative "satsolver"

class TestTry < Test::Unit::TestCase
  def test_simple
    assert_true try [[1], [2]], [true, true]
  end
  def test_negative
    assert_true try [[-1], [-2]], [false, false]
  end
  def test_mixed
    assert_true try [[-1], [2]], [false, true]
  end
  def test_false
    assert_false try [[-1], [2]], [false, false]
  end
#   (x1 | -x5 | x4) &
# (-x1 | x5 | x3 | x4) &
# (-x3 | x4).
#
#   #
  def test_many
      assert_true try([
        [1, -5, 4],
        [-1, 5, 3, 4],
        [-3, 4]
      ], [false, false, false, true, false])
  end
end
