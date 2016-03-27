module Permalink
  module Normalizations
    module LeadingTrailingDashes
      def self.call(input, options)
        input.gsub(/^-?(.*?)-?$/, '\1')
      end
    end
  end
end
