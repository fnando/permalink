require "test_helper"

class NormalizationsTest < Minitest::Test
  test "applies contraction replacement" do
    assert_equal "its", Permalink::Normalizations::Contraction.call("it's")
    assert_equal "aint", Permalink::Normalizations::Contraction.call("ain’t")
  end

  test "applies transliteration" do
    assert_equal "aeiou", Permalink::Normalizations::Transliteration.call("áéíóú")
  end

  test "applies downcasing" do
    assert_equal "test", Permalink::Normalizations::Downcase.call("TEST")
  end

  test "applies lead/trailing dashes replacement" do
    assert_equal "test", Permalink::Normalizations::LeadingTrailingDashes.call("-test-")
  end

  test "applies multiple dashes replacement" do
    assert_equal "nice-permalink", Permalink::Normalizations::MultipleDashes.call("nice----permalink")
  end

  test "applies multiple dashes replacement with custom separator" do
    assert_equal "nice_permalink", Permalink::Normalizations::MultipleDashes.call("nice----permalink", separator: "_")
  end

  test "applies non-alphanumeric replacement" do
    assert_equal "nice-permalink-", Permalink::Normalizations::NonAlphanumeric.call("nice-permalink!")
  end

  test "applies non-alphanumeric replacement with custom separator" do
    assert_equal "nice_permalink_", Permalink::Normalizations::NonAlphanumeric.call("nice-permalink!", separator: "_")
  end
end
