module Permalink
  module Normalizations
    module MultipleDashes
      def self.call(input, options = DEFAULT_OPTIONS)
        input.gsub(/-+/sm, options[:separator])
      end
    end
  end
end
