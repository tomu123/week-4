class ApplicationRepresenter < Representable::Decorator
  include Representable::JSON

  def self.jsonapi_new(*args, &block)
    { data: new(*args, &block) }
  end

  def self.jsonapi_for_collection(*args, &block)
    { data: for_collection.new(*args, &block) }
  end
end
