module Permalink
  module Orm
    module ActiveRecord
      def self.included(base)
        base.extend(ClassMethods)
        base.extend(Permalink::Orm::Base::ClassMethods)
        class << base; attr_accessor :permalink_options; end
      end

      module ClassMethods
        # permalink :title
        # permalink :title, :to => :custom_permalink_field
        # permalink :title, :to => :permalink, :to_param => [:id, :permalink]
        # permalink :title, :unique => true
        def permalink(from, options={})
          include Permalink::Orm::Base::InstanceMethods
          setup_permalink(
            {:to_param => [:id, :permalink]},
            from,
            options
          )
        end
      end
    end
  end
end
