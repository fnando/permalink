module Permalink
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)
      base.extend(Permalink::ActiveRecord::ClassMethods)
      class << base; attr_accessor :permalink_options; end
    end

    module ClassMethods
      # permalink :title
      # permalink :title, :to => :custom_permalink_field
      # permalink :title, :to => :permalink, :to_param => [:id, :permalink]
      # permalink :title, :unique => true
      def permalink(from_column, options = {})
        include InstanceMethods

        options.reverse_merge!({
          to_param: [:id, :permalink],
          to: :permalink,
          unique: false,
          force: false
        })

        self.permalink_options = {
          from_column_name: from_column,
          to_column_name: options[:to],
          to_param: [options[:to_param]].flatten,
          unique: options[:unique],
          force: options[:force]
        }

        before_validation :create_permalink
        before_save :create_permalink
      end
    end

    module InstanceMethods
      def to_param
        to_param_option = self.class.permalink_options[:to_param]

        to_param_option.compact.map {|name|
          respond_to?(name) ? public_send(name).to_s : name.to_s
        }.reject(&:blank?).join("-")
      end

      private
      def next_available_permalink(permalink)
        unique_permalink = permalink

        if self.class.permalink_options[:unique]
          suffix = 2

          while self.class.where(to_permalink_name => unique_permalink).first
            unique_permalink = "#{permalink}-#{suffix}"
            suffix += 1
          end
        end

        unique_permalink
      end

      def from_permalink_name
        self.class.permalink_options[:from_column_name]
      end

      def to_permalink_name
        self.class.permalink_options[:to_column_name]
      end

      def from_permalink_value
        read_attribute(from_permalink_name)
      end

      def to_permalink_value
        read_attribute(to_permalink_name)
      end

      def update_permalink?
        changes[from_permalink_name] &&
        (self.class.permalink_options[:force] || to_permalink_value.blank?)
      end

      def create_permalink
        write_attribute(
          to_permalink_name,
          next_available_permalink(from_permalink_value.to_s.to_permalink)
        ) if update_permalink?
      end
    end
  end
end
