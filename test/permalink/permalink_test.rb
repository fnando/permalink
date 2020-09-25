# frozen_string_literal: true

require "test_helper"

class PermalinkTest < Minitest::Test
  {
    "This IS a Tripped out title!!.!1  (well/ not really)" => "this-is-a-tripped-out-title-1-well-not-really", # rubocop:disable Layout/LineLength
    '////// meph1sto r0x ! \\\\\\' => "meph1sto-r0x",
    "āčēģīķļņū" => "acegiklnu",
    "中文測試 chinese text" => "chinese-text",
    'some-)()()-ExtRa!/// .data==?>   to \/\/test' => "some-extra-data-to-test",
    "http://simplesideias.com.br/tags/" => "http-simplesideias-com-br-tags",
    "Don't Repeat Yourself (DRY)" => "dont-repeat-yourself-dry",
    "Text\nwith\nline\n\n\tbreaks" => "text-with-line-breaks",
    "can't do it" => "cant-do-it",
    "i'm a dog" => "im-a-dog"
  }.each do |from, to|
    test "creates permalink for #{from}" do
      assert_equal to, Permalink.generate(from)
    end
  end
end
