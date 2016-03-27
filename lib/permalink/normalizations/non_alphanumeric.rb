module Permalink
  module Normalizations
    module NonAlphanumeric
      def self.call(input, options)
        input.gsub(/[^-\w\d]+/sim, options[:separator])
      end
    end
  end
end
