module Permalink
  module Orm
    module MongoMapper
      def self.included(base)
        base.extend(Permalink::Orm::Base::ClassMethods)
        base.extend(ClassMethods)
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
            {:to_param => :permalink},
            from,
            options
          )

          key options[:to], String, :index => true
        end
      end
    end
  end
end
