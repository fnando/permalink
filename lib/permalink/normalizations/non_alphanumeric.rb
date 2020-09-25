# frozen_string_literal: true

module Permalink
  module Normalizations
    module NonAlphanumeric
      def self.call(input, options = DEFAULT_OPTIONS)
        regex = /[^#{options[:separator]}a-z0-9]/sim
        input.gsub(regex, options[:separator])
      end
    end
  end
end
