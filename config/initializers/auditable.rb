ActiveSupport.on_load(:active_record) do
  module ActiveRecord
    class Base
      class << self
        def audit_with_destroy(*args)
          audit_without_destroy(*args)
          after_destroy { |record| record.snap!(:action => "destroy") }
          after_restore { |record| record.snap!(:action => "restore") } if respond_to?(:after_restore)
        end
        alias_method_chain :audit, :destroy
      end
    end
  end
  module Auditable
    class Audit
      include UpdateEvent
      def auditable
        klazz = self.auditable_type.split(/::/).inject(Object) { |c, n| c.const_get(n) }
        klazz.unscoped { super }
      end
      def relevant_attributes_with_virtual_attributes
        attributes.slice("modifications", "tag", "action", "user").reject { |k,v| v.blank? }
      end
      alias_method_chain :relevant_attributes, :virtual_attributes
    end
  end
end
