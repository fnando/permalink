class String 
  def to_permalink 
    str = ActiveSupport::Multibyte::Chars.new(self)
    str = str.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
    str.gsub!(/[^-\w\d]+/sim, "-")
    str.gsub!(/-+/sm, "-")
    str.gsub!(/^-?(.*?)-?$/, '\1')
    str.downcase!
    str
  end 
end

module SimplesIdeias
  module Acts
    module Permalink
      def self.included(base)
        base.extend ClassMethods
        
        class << base
          attr_accessor :has_permalink_options
        end
      end
      
      module ClassMethods
        # has_permalink :title
        # has_permalink :title, :to => :custom_permalink_field
        # has_permalink :title, :to => :permalink, :to_param => [:id, :permalink]
        # has_permalink :title, :unique => true
        def has_permalink(from, options={})
          options = {
            :to => :permalink,
            :to_param => [:id, :permalink],
            :unique => false
          }.merge(options)
          
          self.has_permalink_options = {
            :from_column_name => from,
            :to_column_name => options[:to],
            :to_param => [options[:to_param]].flatten,
            :unique => options[:unique]
          }
          
          include SimplesIdeias::Acts::Permalink::InstanceMethods
          
          before_validation :create_permalink
          before_save :create_permalink
        end
      end
      
      module InstanceMethods
        def to_param
          to_param_option = self.class.has_permalink_options[:to_param]
          
          to_param_option.compact.collect do |name| 
            if respond_to?(name)
              send(name).to_s
            else
              name.to_s
            end
          end.reject(&:blank?).join('-')
        end
        
        private
          def next_available_permalink(_permalink)
            the_permalink = _permalink
            
            if self.class.has_permalink_options[:unique]
              suffix = 2
              
              while self.class.first(:conditions => {to_permalink_name => the_permalink})
                the_permalink = "#{_permalink}-#{suffix}"
                suffix += 1
              end
            end

            the_permalink
          end
        
          def from_permalink_name
            self.class.has_permalink_options[:from_column_name]
          end
          
          def to_permalink_name
            self.class.has_permalink_options[:to_column_name]
          end
          
          def from_permalink_value
            read_attribute(from_permalink_name)
          end
          
          def to_permalink_value
            read_attribute(to_permalink_name)
          end
          
          def create_permalink
            unless from_permalink_value.blank? || !to_permalink_value.blank?
              write_attribute(to_permalink_name, next_available_permalink(from_permalink_value.to_s.to_permalink))
            end
          end
      end
    end
  end
end