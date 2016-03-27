require "test_helper"

class NormalizationsTest < Minitest::Test
  test "applies contraction replacement" do
    assert_equal "its", Permalink::Normalizations::Contraction.call("it's")
    assert_equal "aint", Permalink::Normalizations::Contraction.call("ain’t")
  end
end
