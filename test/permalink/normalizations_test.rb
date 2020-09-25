# frozen_string_literal: true

require "test_helper"

class NormalizationsTest < Minitest::Test
  test "applies contraction replacement" do
    assert_equal "its", Permalink::Normalizations::Contraction.call("it's")
    assert_equal "aint", Permalink::Normalizations::Contraction.call("ain’t")
  end

  test "applies transliteration" do
    assert_equal "aeiou",
                 Permalink::Normalizations::Transliteration.call("áéíóú")
  end

  test "applies downcasing" do
    assert_equal "test", Permalink::Normalizations::Downcase.call("TEST")
  end

  test "applies lead/trailing dashes replacement" do
    permalink = Permalink::Normalizations::LeadingTrailingDashes.call("-test-")
    assert_equal "test", permalink
  end

  test "applies multiple dashes replacement" do
    permalink =
      Permalink::Normalizations::MultipleDashes.call("nice----permalink")
    assert_equal "nice-permalink", permalink
  end

  test "applies multiple dashes replacement with custom separator" do
    permalink = Permalink::Normalizations::MultipleDashes
                .call("nice----permalink", separator: "_")
    assert_equal "nice_permalink", permalink
  end

  test "applies non-alphanumeric replacement" do
    permalink =
      Permalink::Normalizations::NonAlphanumeric.call("nice-permalink!")
    assert_equal "nice-permalink-", permalink
  end

  test "applies non-alphanumeric replacement with custom separator" do
    permalink = Permalink::Normalizations::NonAlphanumeric
                .call("nice-permalink!", separator: "_")
    assert_equal "nice_permalink_", permalink
  end
end
