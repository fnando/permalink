# frozen_string_literal: true

module Permalink
  module Normalizations
    module LeadingTrailingDashes
      def self.call(input, _options = nil)
        input.gsub(/^-?(.*?)-?$/, '\1')
      end
    end
  end
end
