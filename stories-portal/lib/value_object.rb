class ValueObject < Struct.new(:id, :name)
  module Attribute
    extend ActiveSupport::Concern

    included do
      def self.value_attribute(name, serializer, default = nil)
        serialize name, serializer
        delegate :id, to: name, prefix: true, allow_nil: true

        after_initialize { self[name] ||= default }

        define_method("#{name}_id=") do |argument|
          return unless argument.to_s.try(:strip).present?
          self.send("#{name}=", serializer.find(argument.try(:to_i)))
        end
      end
    end
  end

  class << self
    def find(id)
      return unless id
      all.find {|value| value.id.to_s.eql?(id.to_s)} || raise(ActiveRecord::RecordNotFound, "#{self.name} with id #{id} not found")
    end
    alias load find

    def dump(value)
      return nil unless value
      value.id
    end
  end
end
