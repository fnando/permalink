module Permalink
  module Normalizations
    module Transliteration
      def self.call(input, _options)
        ActiveSupport::Multibyte::Chars.new(input)
          .normalize(:kd)
          .gsub(/[^\x00-\x7F]/, "")
          .to_s
      end
    end
  end
end
