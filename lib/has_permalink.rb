# Credits: http://groups.google.ca/group/MephistoBlog/browse_thread/thread/afe817a4a594ddde
begin
  require 'unicode' 
rescue LoadError
  puts 'Please run `sudo gem install unicode` to use has_permalink'
end

class String 
  def to_permalink 
    str = Unicode.normalize_KD(self).gsub(/[^\x00-\x7F]/n,'') 
    str = str.gsub(/[^-_\s\w]/, ' ').downcase.squeeze(' ').tr(' ', '-')
    str = str.gsub(/-+/, '-').gsub(/^-+/, '').gsub(/-+$/, '')
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
        # has_permalink :title => :custom_permalink_field
        def has_permalink(options)
          from = options
          to = :permalink
          to_param = [self.primary_key, to]
          
          if options.is_a?(Hash)
            from = options.keys.first
            to = options[from]
            to_param = options[:to_param] if options.key?(:to_param)
          end
          
          self.has_permalink_options = {
            :from_column_name => from,
            :to_column_name => to,
            :to_param => to_param
          }
          
          include SimplesIdeias::Acts::Permalink::InstanceMethods
          
          after_validation :create_permalink
          before_save :create_permalink
        end
      end
      
      module InstanceMethods
        def to_param
          self.class.has_permalink_options[:to_param].collect do |name| 
            if respond_to?(name)
              send(name)
            else
              name
            end
          end.join('-')
        end
        
        private
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
            write_attribute(to_permalink_name, from_permalink_value.to_s.to_permalink) unless from_permalink_value.blank? || to_permalink_value
          end
      end
    end
  end
end