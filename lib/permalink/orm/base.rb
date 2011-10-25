module Permalink
  module Orm
    module Base
      module ClassMethods
        def setup_permalink(orm_options, from, options)
          options.reverse_merge!(orm_options)
          options.reverse_merge!({
            :to     => :permalink,
            :unique => false,
            :force  => false
          })

          self.permalink_options = {
            :from_column_name => from,
            :to_column_name   => options[:to],
            :to_param         => [options[:to_param]].flatten,
            :unique           => options[:unique],
            :force            => options[:force]
          }

          before_validation :create_permalink
          before_save :create_permalink
        end
      end

      module InstanceMethods
        def to_param
          to_param_option = self.class.permalink_options[:to_param]

          to_param_option.compact.collect do |name|
            if respond_to?(name)
              send(name).to_s
            else
              name.to_s
            end
          end.reject(&:blank?).join("-")
        end

        private
        def next_available_permalink(_permalink)
          the_permalink = _permalink

          if self.class.permalink_options[:unique]
            suffix = 2

            while self.class.where(to_permalink_name => the_permalink).first
              the_permalink = "#{_permalink}-#{suffix}"
              suffix += 1
            end
          end

          the_permalink
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
          changes[from_permalink_name] && (self.class.permalink_options[:force] || to_permalink_value.blank?)
        end

        def create_permalink
          if update_permalink?
            write_attribute(to_permalink_name, next_available_permalink(from_permalink_value.to_s.to_permalink))
          end
        end
      end
    end
  end
end
