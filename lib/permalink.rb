# frozen_string_literal: true

require "active_record"
require "permalink/active_record"
require "permalink/normalizations/contraction"
require "permalink/normalizations/downcase"
require "permalink/normalizations/leading_trailing_dashes"
require "permalink/normalizations/multiple_dashes"
require "permalink/normalizations/non_alphanumeric"
require "permalink/normalizations/transliteration"

module Permalink
  DEFAULT_NORMALIZATIONS = [
    Normalizations::Transliteration,
    Normalizations::Downcase,
    Normalizations::Contraction,
    Normalizations::NonAlphanumeric,
    Normalizations::MultipleDashes,
    Normalizations::LeadingTrailingDashes
  ].freeze

  DEFAULT_OPTIONS = {
    normalizations: DEFAULT_NORMALIZATIONS,
    separator: "-"
  }.freeze

  def self.generate(input, options = DEFAULT_OPTIONS)
    options = DEFAULT_OPTIONS.merge(options)

    options[:normalizations].each do |normalization|
      input = normalization.call(input, options)
    end

    input
  end
end

ActiveRecord::Base.include Permalink::ActiveRecord
