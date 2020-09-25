# frozen_string_literal: true

module Permalink
  module Normalizations
    module Contraction
      def self.call(input, _options = nil)
        input.gsub(/['’]/, "")
      end
    end
  end
end
