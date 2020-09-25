# frozen_string_literal: true

module Permalink
  module Normalizations
    module Downcase
      def self.call(input, _options = nil)
        input.downcase
      end
    end
  end
end
