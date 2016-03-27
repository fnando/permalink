module Permalink
  module Normalizations
    module MultipleDashes
      def self.call(input, options)
        input.gsub(/-+/sm, options[:separator])
      end
    end
  end
end
