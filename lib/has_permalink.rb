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
        # has_permalink :title => :permalink, :to_param => [:id, :permalink]
        def has_permalink(from, options={})
          options = {
            :to => :permalink,
            :to_param => [:id, :permalink]
          }.merge(options)
          
          self.has_permalink_options = {
            :from_column_name => from,
            :to_column_name => options[:to],
            :to_param => options[:to_param]
          }
          
          include SimplesIdeias::Acts::Permalink::InstanceMethods
          
          after_validation :create_permalink
          before_save :create_permalink
        end
      end
      
      module InstanceMethods
        def to_param
          self.class.has_permalink_options[:to_param].compact.collect do |name| 
            if respond_to?(name)
              send(name).to_s
            else
              name.to_s
            end
          end.reject(&:blank?).join('-')
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
            unless from_permalink_value.blank? || !to_permalink_value.blank?
              write_attribute(to_permalink_name, from_permalink_value.to_s.to_permalink)
            end
          end
      end
    end
  end
end