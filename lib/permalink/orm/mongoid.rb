module Permalink
  module Orm
    module Mongoid
      include Permalink::Orm::Base::ClassMethods
      attr_accessor :permalink_options

      # You must define your field:
      # field :permalink
      # 
      # Then set it up to used as a permalink
      # permalink :title
      # permalink :title, :to => :custom_permalink_field
      # permalink :title, :to => :permalink, :to_param => [:id, :permalink]
      # permalink :title, :unique => true
      def permalink(from, options={})
        include Permalink::Orm::Base::InstanceMethods
        setup_permalink(
          { :to_param => :permalink },
          from,
          options
        )
      end
    end
  end
end
