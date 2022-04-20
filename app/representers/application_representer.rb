class ApplicationRepresenter < Representable::Decorator
  include Representable::JSON
  property :type, exec_context: :decorator

  def type
    represented.class.to_s.pluralize.downcase
  end

  def self.jsonapi_new(*args, &block)
    { data: new(*args, &block) }
  end

  def self.jsonapi_for_collection(*args, &block)
    { data: for_collection.new(*args, &block) }
  end
end
