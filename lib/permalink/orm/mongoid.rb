module Permalink
  module Orm
    module Mongoid
      include Permalink::Orm::Base::ClassMethods
      attr_accessor :permalink_options

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

        field options[:to]
        key options[:to]
      end
    end
  end
end
