# frozen_string_literal: true

module Permalink
  module Normalizations
    module Transliteration
      def self.call(input, _options = nil)
        input
          .unicode_normalize(:nfkd)
          .gsub(/[^\x00-\x7F]/, "")
          .to_s
      end
    end
  end
end
